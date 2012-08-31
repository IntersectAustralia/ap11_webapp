# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :research_subject_code do
    subject_code 123456
    subject_name "MyString"
  end
end
