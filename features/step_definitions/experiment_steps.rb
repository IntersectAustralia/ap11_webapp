Given /^I have an experiment "([^"]*)"$/ do |title|
  user = FactoryGirl.create(:user, :email => 'experiment@test.com', :password => "Pas$w0rd", :status => 'A')
  FactoryGirl.create(:experiment, :title => title, :date => "2012-01-01", :user => user)
end

Given /^I delete the experiment$/ do
  click_link("form_delete")
end

Given(/^I publish an experiment "(.*?)"$/) do |experiment_name|
  exp = Experiment.find_by_title(experiment_name)
  exp.publish
end
