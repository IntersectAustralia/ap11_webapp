# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input_collection do
    association :experiment
    for_code1 123456
  end
end
