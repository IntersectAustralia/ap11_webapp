class CreateInputCollections < ActiveRecord::Migration
  def change
    create_table :input_collections, :id => false do |t|
      t.integer :experiment_id
      t.integer :collection_id
    end
  end
end
