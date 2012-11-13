class AddPublishedToOutputCollections < ActiveRecord::Migration
  def change
    add_column :output_collections, :published, :boolean
  end
end
