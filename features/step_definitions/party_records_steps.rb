Given /^I have party records$/ do |table|
  table.hashes.each do |hash|
    abbreviation = hash[:abbreviation]
    full_name = hash[:full_name]
    description = hash[:description]
    FactoryGirl.create(:party_record, hash)
  end
end

Given /^I delete the party record$/ do
  click_link("form_delete")
end
