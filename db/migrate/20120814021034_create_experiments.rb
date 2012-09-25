class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.text :title
      t.date :date
      t.timestamps
    end
  end
end
