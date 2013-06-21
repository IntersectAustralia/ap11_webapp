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

Given /^I have an input collection for experiment "([^"]*)"$/ do |title|
  exp = Experiment.find_by_title(title)
  FactoryGirl.create(:input_collection, :experiment => exp)
end

Given(/^I have an input collection called "(.*?)" for experiment "(.*?)"$/) do |collection_name, experiment_name|
  exp =  Experiment.find_by_title(experiment_name)
  FactoryGirl.create(:input_collection, :experiment => exp, :name => collection_name)
end


Given(/^I have an input collection "(.*?)" for experiment "(.*?)" for party record "(.*?)"$/) do |collection_name, experiment_name, party_record|
  exp =  Experiment.find_by_title(experiment_name)
  part_rec = FactoryGirl.create(:party_record, :description => party_record)
  FactoryGirl.create(:input_collection, :experiment => exp, :name => collection_name, :party_record => part_rec)
end


Given /^I delete the input collection/ do
  click_link("form_delete")
end


Given(/^I visit input collection page for "(.*?)" for experiment "(.*?)"$/) do |input_name, experiment_name|
  exp =  Experiment.find_by_title(experiment_name)
  inp_col = InputCollection.find_by_name(input_name)
  visit  root_path + "experiments/#{exp.id.to_s}/input_collections/#{inp_col.id.to_s}"
end