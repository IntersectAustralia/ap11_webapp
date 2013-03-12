class LazyString
  def initialize(callable)
    self.initializing_callable = callable
  end
  def to_s
    cached_str ||= initializing_callable.call.to_s
  end
  def method_missing(sym, *args, &block)
    to_s.send(sym, *args, &block)
  end
  def respond_to?(sym)
    to_s.respond_to?(sym)
  end

  private

  attr_accessor :initializing_callable, :cached_str
end

OaiRepository.setup do |config|

  config.repository_name = 'Proteomic-Genomic Nexus'

  # The URL from which this OAI Repository is served.
  # If you're deploying to different hostnames (e.g. development, QA and
  # production environments, each with different hostnames), you could
  # dynamically set this.
  config.repository_url = LazyString.new(lambda { Rails.application.routes.url_helpers.oai_repository_url(ActionController::Base.default_url_options)})

  # By default the (unique) identifier of each record will be composed as
  # #{record_prefix}/#{record.id}
  # This is probably not want you want, especially if you have multiple record
  # sets (i.e. this provider serves multiple ActiveRecord models)
  #
  # Most probably you'll create an oai_dc_identifier attribute or method in
  # the AR models you intend to serve. That value will supplant the default.
  config.record_prefix = LazyString.new(lambda { Rails.application.routes.url_helpers.root_url(ActionController::Base.default_url_options)})

  # This is your repository administrator's email address.
  # This will appear in the information returned from an "Identify" call to
  # your repository
  config.admin_email = APP_CONFIG['oai_admin_email']

  # The number of records shown at a time (when doing a ListRecords)
  config.limit = 100

  # The values for "models" should be the class name of the ActiveRecord model 
  # class that is being identified with the given set. It doesn't actually have
  # to be a ActiveRecord model class, but it should act like one.
  #
  # You must supply at least one model.
  config.models = [User, PartyRecord, InputCollection, OutputCollection, Service, StaticPartyRecords]

  # List the sets (and the ActiveRecord model they belong to). E.g.
  #
  # config.sets = [
  #   {
  #     spec: 'class:party',
  #     name: 'Parties',
  #     model: Person
  #   },
  #   {
  #     spec: 'class:service',
  #     name: 'Services',
  #     model: Instrument,
  #     description: 'Things that are services'
  #   }
  # ]
  #
  #
  config.sets = [
    {
      spec: 'class:party',
      name: 'Parties',
      model: User
    },
    {
      spec: 'class:party',
      name: 'Party Records',
      model: PartyRecord
    },
    {
      spec: 'class:collection',
      name: 'Input Collections',
      model: InputCollection
    },
    {
      spec: 'class:collection',
      name: 'Output Collections',
      model: OutputCollection
    },
    {
      spec: 'class:party',
      name: 'Static Party Records',
      model: StaticPartyRecords
    },
    {
      spec: 'class:service',
      name: 'Service',
      model: Service
    }
  ]

  # By default, an OAI repository must emit its records in OAI_DC (Dublin Core)
  # format. If you want to provide other output formats for your repository
  # (and those formats are subclasses of OAI::Provider::Metadata.Format) then
  # you can specify them here. E.g.
  #
  require 'rifcs_format'

  config.additional_formats = [
     OAI::Provider::Metadata::RIFCS
  ]
end
