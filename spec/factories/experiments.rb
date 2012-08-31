# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :experiment do
    title "MyString"
    date "2012-08-13"
    association :user
  end
end
