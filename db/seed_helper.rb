def create_roles_and_permissions
  Permission.delete_all
  Role.delete_all

  #TODO: create your roles here
  superuser = "admin"
  researcher = "researcher"
  Role.create!(:name => superuser)
  Role.create!(:name => researcher)

  #TODO: set your own permissions here
  create_permission("User", "read", [superuser])
  create_permission("User", "update_role", [superuser])
  create_permission("User", "activate_deactivate", [superuser])
  create_permission("User", "admin", [superuser])
  create_permission("User", "reject", [superuser])
  create_permission("User", "approve", [superuser])

  #TODO: create more permissions here
end

def create_permission(entity, action, roles)
  permission = Permission.new(:entity => entity, :action => action)
  permission.save!
  roles.each do |role_name|
    role = Role.where(:name => role_name).first
    role.permissions << permission
    role.save!
  end
end
#INSERT INTO `party_records` (`id`, `abbreviation`, `full_name`, `description`, `address`, `url`, `for_code1`, `for_code2`, `for_code3`, `access_rights`, `license`, `created_at`, `updated_at`) VALUES (2,'UNSW','The Ramaciotti Centre','<p>\r\n       The Ramaciotti Centre is a not-for-profit facility located at the University of New South Wales, Sydney, Australia. We are a leading high-throughput functional genomics service provider, offering expertise in next-generation sequencing and microarray technology.</p>\r\n','<p>\r\n        http://www.ramaciotti.unsw.edu.au/</p>\r\n','http://www.ramaciotti.unsw.edu.au/','060408 - Genomics','060405 - Gene Expression (Incl. Microarray and Other Genome-Wide Approaches)','','N/A','N/A','2013-04-02 01:34:23','2013-04-02 23:34:56'),(3,'SBI','The NSW Systems Biology Initiative','<p>\r\n  Funded by the Australian Research Council, NSW State Government and the EIF Super Science Scheme, we are a non-profit facility within the <a href=\"http://www.babs.unsw.edu.au/\">School of Biotechnology and Biomolecular Sciences</a> at the <a href=\"http://www.unsw.edu.au/\">University of New South Wales</a>.</p>\r\n<p>\r\n   Our mission is to become Australia&amp;rsquo;s foremost centre for Systems Biology, undertaking basic and applied research in the development and application of bioinformatics for genomics and proteomics.</p>\r\n<p>\r\n     <br />\r\n      We work closely with users of the NCRIS-funded -omics facilities, specifically the <a href=\"http://www.ramaciotti.unsw.edu.au/\">Ramaciotti Centre</a> for Gene Function Analysis, the <a href=\"http://www.bmsf.unsw.edu.au/\">Bioanalytical Mass Spectrometry Facility</a> (BMSF), the <a href=\"http://www.proteome.org.au/\">Australian Proteome Analysis Facility </a>(APAF) and <a href=\"http://www.scu.edu.au/scps/\">Southern Cross Plant Science</a> at Southern Cross University.</p>\r\n','<p>\r\n <span style=\"color: rgb(51, 51, 51); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;\">Room 263C, Biological Sciences Building</span><br style=\"color: rgb(51, 51, 51); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;\" />\r\n      <span style=\"color: rgb(51, 51, 51); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;\">School of Biotechnology and Biomolecular Sciences</span><br style=\"color: rgb(51, 51, 51); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;\" />\r\n    <span style=\"color: rgb(51, 51, 51); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;\">University of New South Wales</span><br style=\"color: rgb(51, 51, 51); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;\" />\r\n        <span style=\"color: rgb(51, 51, 51); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;\">Sydney, Australia</span></p>\r\n','http://www.systemsbiology.org.au/','060114 - Systems Biology','','','N/A','N/A','2013-04-02 01:35:55','2013-05-07 04:40:35')