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
      | entity | action          | roles |
      | User   | read            | admin |
      | User   | admin           | admin |
      | User   | access_requests | admin |
    And I have a user "georgina@intersect.org.au"
    And "georgina@intersect.org.au" has role "admin"
    And I am logged in as "georgina@intersect.org.au"

  Scenario: Create experiment
    Given I am on the home page
    And I follow "View Experiments"
    Then I should see "Listing experiments"
    Then I follow "New Experiment"
    And I fill in "Title" with "Proteome"
    And I fill in "Date" with "2012-09-24"
    And I press "Create Experiment"
    Then I should see "Experiment was successfully created."
    And I should see "Proteome"
    And I should see "2012-09-24"
    And I should see "Fred Bloggs"

  @wip
  Scenario: Edit experiment
    Given I am on the home page
    And I have an experiment "Old proteome"
    And I follow "View Experiments"
    Then I follow "Show"