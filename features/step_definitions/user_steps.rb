Given(/^I visit user page for "(.*?)"$/) do |email|
  visit user_path(User.find_by_email(email).id)
end
