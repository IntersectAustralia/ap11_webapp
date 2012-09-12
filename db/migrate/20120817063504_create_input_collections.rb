class CreateInputCollections < ActiveRecord::Migration
  def change
    create_table :input_collections do |t|
      t.string  :name,          :limit => '512'
      t.text    :description
      t.text    :license
      t.text    :access_rights
      t.text    :location
      t.string  :for_code1
      t.string  :for_code2
      t.string  :for_code3
      t.string  :website_name,  :limit => '512'
      t.string  :url,           :limit => '2000'
      t.integer :experiment_id
      t.timestamps
    end
  end
end
