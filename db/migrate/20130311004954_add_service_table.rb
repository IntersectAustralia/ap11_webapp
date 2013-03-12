class AddServiceTable < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :description, limit: 2000
      t.string :name, limit: 2000
      t.string :access_rights, limit: 2000
      t.string :license, limit: 2000
      t.text :location
      t.string :url,          :limit => '2000'
      t.boolean :published
      t.timestamps
    end
  end
end
