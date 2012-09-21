# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :party_record do
    abbreviation "MyString"
    full_name "MyString"
    description "MyText"
    address "MyText"
    url "MyString"
    for_code1 "MyString"
    for_code2 "MyString"
    for_code3 "MyString"
    access_rights "MyText"
    license "MyText"
  end
end
