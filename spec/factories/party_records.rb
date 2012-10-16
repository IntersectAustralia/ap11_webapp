# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :party_record do|f|
    f.abbreviation "MyString"
    f.full_name "MyString"
    f.description "MyText"
    f.address "MyText"
    f.url "MyString"
    f.for_code1 "MyString"
    f.for_code2 "MyString"
    f.for_code3 "MyString"
    f.access_rights "MyText"
    f.license "MyText"
  end
end
