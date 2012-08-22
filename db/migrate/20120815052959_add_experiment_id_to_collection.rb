class AddExperimentIdToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :experiment_id, :integer
  end
end
