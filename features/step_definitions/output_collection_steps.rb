
Given(/^I have an output collection called "(.*?)" for experiment "(.*?)"$/) do |collection_name, experiment_name|
  exp =  Experiment.find_by_title(experiment_name)
  FactoryGirl.create(:output_collection, :experiment => exp, :name => collection_name)
end

Given(/^I visit output collection page for "(.*?)" for experiment "(.*?)"$/) do |input_name, experiment_name|
  exp =  Experiment.find_by_title(experiment_name)
  inp_col = OutputCollection.find_by_name(input_name)
  visit  root_path + "experiments/#{exp.id.to_s}/output_collections/#{inp_col.id.to_s}"
end