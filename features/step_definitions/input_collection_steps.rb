When /^I add the FOR code "(.*?)" in input collection$/ do |code|
  find("#s2id_input_collection_for_code1 a.select2-choice").click
  find(".select2-input").set(code)
end

Given /^I have the following FOR codes$/ do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:research_subject_code, hash)
  end
end

When /^I select collection type "(.*?)"$/ do |type|
  choose(type)
end
