class User < ActiveRecord::Base
  include RIFCS::Party

  DATE_FORMAT = '%Y-%m-%dT%H:%M:%SZ'
  ADDRESS = 'SomeBuildingHere<br />University of New South Wales<br />NSW 2109<br />Australia'
  # Include devise modules
  devise :database_authenticatable, :registerable, :lockable, :recoverable, :trackable, :validatable, :timeoutable

  belongs_to :role

  has_many :experiment, :foreign_key => 'user_id'

  # Setup accessible attributes (status/approved flags should NEVER be accessible by mass assignment)
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :title, :description, :home_page, :for_code1, :for_code2, :for_code3

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :status

  validates_length_of :first_name, :maximum => 255
  validates_length_of :last_name, :maximum => 255
  validates_length_of :email, :maximum => 255
  validates_length_of :title, :maximum => 63
  validates_length_of :home_page, :maximum => 255

  with_options :if => :password_required? do |v|
    v.validates :password, :password_format => true
  end

  before_validation :initialize_status

  scope :pending_approval, where(:status => 'U').order(:email)
  scope :approved, where(:status => 'A').order(:email)
  scope :deactivated_or_approved, where("status = 'D' or status = 'A' ").order(:email)
  scope :approved_superusers, joins(:role).merge(User.approved).merge(Role.superuser_roles)

  # Override Devise active for authentication method so that users must be approved before being allowed to log in
  # https://github.com/plataformatec/devise/wiki/How-To:-Require-admin-to-activate-account-before-sign_in
  def active_for_authentication?
    super && approved?
  end

  # Override Devise method so that user is actually notified right after the third failed attempt.
  def attempts_exceeded?
    self.failed_attempts >= self.class.maximum_attempts
  end

  # Overrride Devise method so we can check if account is active before allowing them to get a password reset email
  def send_reset_password_instructions
    if approved?
      generate_reset_password_token!
      ::Devise.mailer.reset_password_instructions(self).deliver
    else
      if pending_approval? or deactivated?
        Notifier.notify_user_that_they_cant_reset_their_password(self).deliver
      end
    end
  end

  # Custom method overriding update_with_password so that we always require a password on the update password action
  # Devise expects the update user and update password to be the same screen so accepts a blank password as indicating that
  # the user doesn't want to change it
  def update_password(params={})
    current_password = params.delete(:current_password)

    result = if valid_password?(current_password)
               update_attributes(params)
             else
               self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
               self.attributes = params
               false
             end

    clean_up_passwords
    result
  end

  # Override devise method that resets a forgotten password, so we can clear locks on reset
  def reset_password!(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    clear_reset_password_token if valid?
    if valid?
      unlock_access! if access_locked?
    end
    save
  end


  def approved?
    self.status == 'A'
  end

  def pending_approval?
    self.status == 'U'
  end

  def deactivated?
    self.status == 'D'
  end

  def rejected?
    self.status == 'R'
  end

  def deactivate
    self.status = 'D'
    save!(:validate => false)
  end

  def activate
    self.status = 'A'
    save!(:validate => false)
  end

  def approve_access_request
    self.status = 'A'
    save!(:validate => false)

    # send an email to the user
    Notifier.notify_user_of_approved_request(self).deliver
  end

  def reject_access_request
    self.status = 'R'
    save!(:validate => false)

    # send an email to the user
    Notifier.notify_user_of_rejected_request(self).deliver
  end

  def notify_admin_by_email
    Notifier.notify_superusers_of_access_request(self).deliver
  end

  def check_number_of_superusers(id, current_user_id)
    current_user_id != id.to_i or User.approved_superusers.length >= 2
  end

  def self.get_superuser_emails
    approved_superusers.collect { |u| u.email }
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def sets
    [
      OAI::Set.new({:name => 'Parties', :spec => 'class:party'})
    ]
  end

  #Required by OAI Repository
  def party_group
    'University of New South Wales'
  end

  def party_key
    view_url
  end

  def party_originating_source
    url_opts = ActionController::Base.default_url_options
    Rails.application.routes.url_helpers.users_url(url_opts)
  end

  def party_date_modified
    updated_at.strftime(DATE_FORMAT)
  end

  def party_type
    'person'
  end

  def party_names
    [
      {
        :xmllang => 'en',
        :type => 'primary',
        :name_parts => [
          {
            :value => title,
            :type => 'title'
          },
          {
            :value => first_name,
            :type => 'given'
          },
          {
            :value => last_name,
            :type => 'family'
          }
        ]
      }
    ]
  end

  def party_descriptions
    [
      {
          :value => "#{description}",
          :type => 'brief'
      }
    ]
  end

  def party_locations
    [
      {
        :addresses => [
          {
            :electronic => [
              {
                :type => 'url',
                :value => home_page,
              }
          ],
          :physical => [
              {
                :type => 'streetAddress',
                :address_parts => [
                  {
                    :type => 'addressLine',
                    :value => ADDRESS
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  end

  def party_subjects
    subjects = []
    subjects.push(
        {
          :value => subject_code(for_code1),
          :type => 'anzsrc-for'
        }) unless for_code1.blank?
    subjects.push(
        {
          :value => subject_code(for_code2),
          :type => 'anzsrc-for'
        }) unless for_code2.blank?
    subjects.push(
        {
          :value => subject_code(for_code3),
          :type => 'anzsrc-for'
        }) unless for_code3.blank?
    subjects
  end

  def oai_dc_identifier
    view_url
  end

  def oai_dc_description
    description
  end


  def published
    size = OutputCollection.where(:published => true, :experiment_id => experiment.where(:published => true).select("id")).size
    size += InputCollection.where(:published => true, :collect_type => 'Local', :experiment_id => experiment.where(:published => true).select("id")).size
    size > 0
  end
  private

  def initialize_status
    self.status = "U" unless self.status
  end

  def view_url
    url_opts = ActionController::Base.default_url_options
    Rails.application.routes.url_helpers.user_url(self, url_opts)
  end

  def subject_code(for_code)
    for_code.to_s.split(' - ')[0]
  end
end
