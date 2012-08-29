class CreateResearchSubjectCodes < ActiveRecord::Migration
  def change
    create_table :research_subject_codes do |t|
      t.integer :subject_code
      t.string :subject_name

      t.timestamps
    end
  end
end
