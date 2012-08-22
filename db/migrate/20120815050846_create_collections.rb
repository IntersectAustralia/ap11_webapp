class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.integer :for_codes
      t.text :citation_info

      t.timestamps
    end
  end
end
