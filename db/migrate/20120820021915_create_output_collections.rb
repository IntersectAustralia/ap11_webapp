class CreateOutputCollections < ActiveRecord::Migration
  def change
    create_table :output_collections, :id => false do |t|
      t.integer :experiment_id
      t.integer :collection_id
    end
  end
end
