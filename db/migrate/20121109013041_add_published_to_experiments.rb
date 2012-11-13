class AddPublishedToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :published, :boolean
  end
end
