class AddPublishedToInputCollections < ActiveRecord::Migration
  def change
    add_column :input_collections, :published, :boolean
  end
end
