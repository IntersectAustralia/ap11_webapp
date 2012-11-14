class InputCollection < ActiveRecord::Base
  include RIFCS::Collection

  DATE_FORMAT = '%Y-%m-%dT%H:%M:%SZ'
  REMOTE = "Remote"
  LOCAL = "Local"

  attr_accessible :experiment_id, :name, :license, :access_rights, :location, :for_code1, :for_code2, :for_code3,
                  :description, :website_name, :url, :collect_type, :party_record_id

  belongs_to :experiment
  belongs_to :party_record

  before_validation :strip_whitespace

  validates_length_of :name, :maximum => 512
  validates_length_of :license, :maximum => 2000
  validates_length_of :access_rights, :maximum => 2000
  validates_length_of :location, :maximum => 2000
  validates_length_of :website_name, :maximum => 512
  validates_length_of :url, :maximum => 2000

  validates_presence_of :name
  validates_presence_of :for_code1
  validates_presence_of :collect_type
  validates_presence_of :url, :if => :website_name_exists?
  validates_presence_of :website_name, :if => :url_exists?

  validates_uniqueness_of :name, :scope => :experiment_id, :case_sensitive => false

  def website_name_exists?
    !website_name.blank?
  end

  def url_exists?
    !url.blank?
  end

  #Required for OAI repository
  def oai_published
    published
  end

  def collection_group
    'University of New South Wales'
  end

  def collection_key
    view_url
  end

  def collection_originating_source
    url_opts = ActionController::Base.default_url_options
    Rails.application.routes.url_helpers.experiment_input_collections_url(experiment_id, url_opts)
  end

  def collection_date_accessioned
    created_at.strftime(DATE_FORMAT)
  end

  def collection_date_modified
    updated_at.strftime(DATE_FORMAT)
  end

  def collection_type
    'dataset'
  end

  def collection_descriptions
    [
      {
        value: description,
        type: 'brief'
      }
    ]
  end

  def collection_names
    [
      {
        xmllang: 'en',
        type: 'primary',
        name_parts: [
          {
            value: name
          }
        ]
      }
    ]
  end

  def collection_rights
    if collect_type.eql? REMOTE
      [
          {
              licence: {
                  value: license,
                  type: 'Unknown/Other'
              },
              access_rights: {
                  value: access_rights
              }
          }
      ]
    elsif collect_type.eql? LOCAL
      [
          {
              licence: {
                  value: OAI_CONFIG['license'],
                  type: 'Unknown/Other'
              },
              access_rights: {
                  value: OAI_CONFIG['access_rights']
              }
          }
      ]
    end
  end

  def collection_subjects
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

  def collection_locations
    web_url = OAI_CONFIG['website_url']
    if collect_type.eql? REMOTE
      web_url = url
    end

    [
      {
        addresses: [
          {
            electronic: [
              {
                type: 'url',
                value: web_url,
              }
            ],
            physical: [
              {
                type: 'streetAddress',
                address_parts: [
                  {
                    type: 'addressLine',
                    value: location
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  end

  def collection_related_objects
    exp = Experiment.find(experiment_id)
    if collect_type.eql? REMOTE
      pr = PartyRecord.find(party_record_id)
      key = pr.oai_dc_identifier
      {
          is_owned_by: [
              {
                  key: key
              }
          ],
          is_managed_by: [
            {
                key: key
            }
          ]
      }
    elsif collect_type.eql? LOCAL
      usr = User.find(exp.user_id)
      key = usr.oai_dc_identifier
      {
          is_owned_by: [
              {
                  key: key
              }
          ],
          is_managed_by: [
              {
                  key: key
              }
          ]
      }
    end

  end

  def oai_dc_identifier
    view_url
  end

  def oai_dc_description
    description
  end

  protected

  def strip_whitespace
    self.name.strip! unless name.blank?
  end

  private

  def view_url
    url_opts = ActionController::Base.default_url_options
    Rails.application.routes.url_helpers.experiment_input_collection_url(experiment_id, self, url_opts)
  end

  def subject_code(for_code)
    for_code.to_s.split(' - ')[0]
  end
end
