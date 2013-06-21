Given(/^I have an service "(.*?)"$/) do |service_name|
  FactoryGirl.create(:service, :name => service_name)
end

Given(/^I publish a service "(.*?)"$/) do |service_name|
  service = Service.find_by_name(service_name)
  service.published= true
  service.save!
end

Given(/^I visit service page for "(.*?)"$/) do |service_name|
  visit service_path(Service.find_by_name(service_name).id)
end