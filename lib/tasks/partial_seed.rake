namespace :db do
  namespace :seed do

    desc "Create static records"
    task :insert_static_data => :environment do
      service_hash = {
          :description => 'Proteomic-Genomic Nexus',
          :name => 'Proteomic-Genomic Nexus',
          :published => false
      }
      Service.create!(service_hash)
      party_hashes = [{
                          :abbreviation => 'NSW Systems Biology Initiative',
                          :full_name => 'NSW Systems Biology Initiative',
                          :description => 'NSW Systems Biology Initiative',
                          :published => true
                      },{
                          :abbreviation => 'Ramaciotti Centre',
                          :full_name => 'Ramaciotti Centre',
                          :description => 'Ramaciotti Centre',
                          :published => true
                      }]
      party_hashes.each do |attrs|
        StaticPartyRecords.create! (attrs)
      end
    end
  end
end