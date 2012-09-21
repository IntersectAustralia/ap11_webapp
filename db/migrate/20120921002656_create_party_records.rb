class CreatePartyRecords < ActiveRecord::Migration
  def change
    create_table :party_records do |t|
      t.string :abbreviation
      t.string :full_name
      t.text :description
      t.text :address
      t.string :url
      t.string :for_code1
      t.string :for_code2
      t.string :for_code3
      t.text :access_rights
      t.text :license

      t.timestamps
    end
  end
end
