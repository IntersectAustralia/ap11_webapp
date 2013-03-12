class Service < ActiveRecord::Base
  include RIFCS::Service
  DATE_FORMAT = '%Y-%m-%dT%H:%M:%SZ'
  attr_accessible :published, :description, :name
  #Required for OAI repository

  def service_group
    'University of New South Wales'
  end

  def service_key
    view_url
  end

  def service_type
    "transform"
  end
  #def service_originating_source
  #  url_opts = ActionController::Base.default_url_options
  #  Rails.application.routes.url_helpers.service_url(url_opts)
  #end

  def service_date_accessioned
    created_at.strftime(DATE_FORMAT)
  end

  def service_date_modified
    updated_at.strftime(DATE_FORMAT)
  end


  def service_descriptions
    [
        {
            value: description,
            type: 'brief'
        }
    ]
  end

  def service_names
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

  def service_rights
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
  end

  def service_locations
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

  def service_related_objects

    rc = StaticPartyRecords.find_by_abbreviation("Ramaciotti Centre")
    bi = StaticPartyRecords.find_by_abbreviation("NSW Systems Biology Initiative")

    {
        has_association_with: [
            {
                key: rc.oai_dc_identifier
            }
        ],
        is_managed_by: [
            {
                key: bi.oai_dc_identifier
            }
        ]
    }
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
    Rails.application.routes.url_helpers.service_url(self, url_opts)
  end
end