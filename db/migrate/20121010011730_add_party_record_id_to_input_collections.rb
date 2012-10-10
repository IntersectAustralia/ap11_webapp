class AddPartyRecordIdToInputCollections < ActiveRecord::Migration
  def change
    add_column :input_collections, :party_record_id, :integer
  end
end
