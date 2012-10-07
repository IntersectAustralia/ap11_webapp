# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :research_subject_code do |f|
    f.sequence(:subject_code) { |n| "#{n}" }
    f.sequence(:subject_name) { |n| "#{n}" }
  end
end
