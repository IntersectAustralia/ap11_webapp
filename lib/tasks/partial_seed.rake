namespace :db do
  namespace :seed do

    desc "Create static records"
    task :insert_static_data => :environment do
      nsw_systems_description = <<EOM
                          Funded by the Australian Research Council, NSW State Government and the EIF Super Science Scheme, we are a non-profit facility within the &lt;a href="http://www.babs.unsw.edu.au/"&gt;School of Biotechnology and Biomolecular Sciences&lt;/a&gt; at the &lt;a href="http://www.unsw.edu.au/"&gt;University of New South Wales&lt;/a&gt;.&lt;/p&gt;
                          &lt;p&gt;
                            Our mission is to become Australia&amp;rsquo;s foremost centre for Systems Biology, undertaking basic and applied research in the development and application of bioinformatics for genomics and proteomics.&lt;/p&gt;
                          &lt;p&gt;
                            We work closely with users of the NCRIS-funded -omics facilities, specifically the &lt;a href="http://www.ramaciotti.unsw.edu.au/"&gt;Ramaciotti Centre&lt;/a&gt; for Gene Function Analysis, the &lt;a href="http://www.bmsf.unsw.edu.au/"&gt;Bioanalytical Mass Spectrometry Facility&lt;/a&gt; (BMSF), the &lt;a href="http://www.proteome.org.au/"&gt;Australian Proteome Analysis Facility&lt;/a&gt; (APAF) and &lt;a href="http://www.scu.edu.au/scps/"&gt;Southern Cross Plant Science&lt;/a&gt; at Southern Cross University.&lt;/p&gt;
EOM
      service_hash = {
          :description => "The Proteomic Genomic Nexus is a software tool that:</p>
<ol>
<li>
allows genomics and transcriptomics data from next-generation sequencing to be integrated with that from proteomics, and</li>
<li>
allows the integrated data to assist in the confirmation of open reading frames and/or splice isoforms in a directed or naive way.</li>
</ol>
",
          :name => 'Proteomic Genomic Nexus',
          :url => 'http://www.intersect.org.au/proteomic-genomic-nexus',
          :published => true
      }

      Service.delete_all
      Service.create!(service_hash)
      party_hashes = [{
                          :abbreviation => 'NSW Systems Biology Initiative',
                          :full_name => 'NSW Systems Biology Initiative',
                          :description => nsw_systems_description,
                          :url => 'http://www.systemsbiology.org.au/',
                          :published => true
                      },{
                          :abbreviation => 'Ramaciotti Centre',
                          :full_name => 'Ramaciotti Centre',
                          :description => 'The Ramaciotti Centre is a not-for-profit facility located at the University of New South Wales, Sydney, Australia. We are a leading high-throughput functional genomics service provider, offering expertise in next-generation sequencing and microarray technology',
                          :url => 'http://www.ramaciotti.unsw.edu.au/',
                          :published => true
                      }]
      StaticPartyRecords.delete_all
      party_hashes.each do |attrs|
        StaticPartyRecords.create! (attrs)
      end
    end
  end
end