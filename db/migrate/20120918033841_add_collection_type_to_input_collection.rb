class AddCollectionTypeToInputCollection < ActiveRecord::Migration
  def change
    add_column :input_collections, :collection_type, :string
  end
end
