class AddStaticParty < ActiveRecord::Migration
  def change
    create_table :static_party_records do |t|
      t.string :abbreviation
      t.string :full_name
      t.text :description
      t.text :address
      t.string :url,          :limit => '2000'
      t.string :for_code1
      t.string :for_code2
      t.string :for_code3
      t.text :access_rights
      t.text :license
      t.boolean  :published
      t.timestamps
    end
  end

end
