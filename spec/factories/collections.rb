# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collection do
    name "MyString"
    description "MyText"
    for_codes 1
    citation_info "MyText"
  end
end
