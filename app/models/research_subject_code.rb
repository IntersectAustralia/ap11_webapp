class ResearchSubjectCode < ActiveRecord::Base
  attr_accessible :subject_code, :subject_name

  def display_name
    "#{subject_code} - #{subject_name}".strip
  end
end
