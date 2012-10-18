# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input_collection do
    association :experiment
    name "Proteome"
    collect_type "Remote"
    for_code1 123456
  end
end
