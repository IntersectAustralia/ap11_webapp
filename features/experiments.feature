Feature: Experiments
  In order to use the system
  As a user
  I want to manipulate experiments

  Background:
    Given I have roles
      | name       |
      | admin  |
      | Researcher |
    And I have permissions
      | entity | action          | roles     |
      | User   | read            | admin |
      | User   | admin           | admin |
      | User   | access_requests | admin |
    And I have a user "georgina@intersect.org.au"
    And "georgina@intersect.org.au" has role "admin"
    And I am logged in as "georgina@intersect.org.au"

  Scenario: Successful login
    Given I am on the home page
