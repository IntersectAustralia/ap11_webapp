Feature: Navigation
  In order to have quick access to all pages on the website
  As a user
  I want to have a working navigation panel

  Background:
    Given I have a user "georgina@intersect.org.au"
    And I am on the login page
    And I am logged in as "georgina@intersect.org.au"


  Scenario: Unverified user should only see options to login/home
    Given I am on the home page
    When I follow "Logout"
    Then I should see "QUICK LINKS"
    And I should see "Home"
    And I should see "Login/Sign up"
    And I follow the home page
    Then I should be on the home page
    And I follow "Login/Sign up"
    Then I should be on the home page

  Scenario: Logged in user should see all navigation options
    Given I am on the home page
    Then I should see "QUICK LINKS"
    And I should see "Home"
    And I should not see "Login/Sign up"
    And I should see "View Experiments"
    And I should see "View Users"
    And I should see "View Access Requests"

  Scenario: View experiments link takes user to experiments page
    Given I am on the home page
    And I Follow "View Experiments"
    Then I should be on the list experiments page

  Scenario: View User link takes user to users page
    Given I am on the home page
    And I Follow "View Users"
    Then I should be on the list users page

   Scenario: View Access Requests link takes user to requests page
    Given I am on the home page
    And I Follow "View Access Requests"
    Then I should be on the access requests page






