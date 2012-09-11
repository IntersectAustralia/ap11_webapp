class CreateResearchSubjectCodes < ActiveRecord::Migration
  def change
    create_table :research_subject_codes do |t|
      t.string :subject_code
      t.string :subject_name
    end
  end
end
