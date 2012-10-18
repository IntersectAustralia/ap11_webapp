class AddCollectionTypeToInputCollection < ActiveRecord::Migration
  def change
    add_column :input_collections, :collect_type, :string
  end
end
