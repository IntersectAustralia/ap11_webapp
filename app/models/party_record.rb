class PartyRecord < ActiveRecord::Base
  include RIFCS::Party

  DATE_FORMAT = '%Y-%m-%dT%H:%M:%SZ'

  attr_accessible :abbreviation, :access_rights, :address, :description, :for_code1, :for_code2, :for_code3,
                  :full_name, :license, :url

  has_many :input_collection, :foreign_key => 'party_record_id'

  before_validation :strip_whitespace

  validates_presence_of :abbreviation
  validates_presence_of :full_name
  validates_presence_of :description
  validates_presence_of :address
  validates_presence_of :access_rights
  validates_presence_of :license

  validates_length_of :abbreviation, :maximum => 25
  validates_length_of :full_name, :maximum => 255
  validates_length_of :url, :maximum => 2000

  validates_uniqueness_of :abbreviation, :case_sensitive => false

  #Required by OAI Repository
  def party_group
    'University of New South Wales'
  end

  def party_key
    view_url
  end

  def party_originating_source
    url_opts = ActionController::Base.default_url_options
    Rails.application.routes.url_helpers.party_records_url(url_opts)
  end

  def party_date_modified
    updated_at.strftime(DATE_FORMAT)
  end

  def party_type
    'group'
  end

  def party_names
    [
      {
        xmllang: 'en',
        type: 'abbreviated',
        name_parts: [
          {
            value: abbreviation
          }
        ]
      },
      {
        xmllang: 'en',
        type: 'primary',
        name_parts: [
          {
            value: full_name
          }
        ]
      }
    ]
  end

  def party_descriptions
    [
      {
        value: "#{description}",
        type: 'brief'
      }
    ]
  end

  def party_locations
    [
      {
        addresses: [
          {
            electronic: [
              {
                type: 'url',
                value: url,
              }
            ],
            physical: [
              {
                type: 'streetAddress',
                address_parts: [
                  {
                    type: 'text',
                    value: address
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
            value: subject_code(for_code1),
            type: 'anzsrc-for'
        }) unless for_code1.blank?
    subjects.push(
        {
            value: subject_code(for_code2),
            type: 'anzsrc-for'
        }) unless for_code2.blank?
    subjects.push(
        {
            value: subject_code(for_code3),
            type: 'anzsrc-for'
        }) unless for_code3.blank?
  end

  def oai_dc_identifier
    view_url
  end

  def oai_dc_description
    description
  end

  protected

  def strip_whitespace
    self.abbreviation.strip! unless abbreviation.blank?
  end

  private

  def view_url
    url_opts = ActionController::Base.default_url_options
    Rails.application.routes.url_helpers.party_record_url(self, url_opts)
  end

  def subject_code(for_code)
    for_code.to_s.split(' - ')[0]
  end
end
