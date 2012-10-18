Feature: Input Collections
  In order to use the system
  As a user
  I want to add input collections to experiments

  Background:
    Given I have roles
      | name       |
      | admin      |
      | Researcher |
    And I have permissions
      | entity | action          | roles |
      | User   | read            | admin |
      | User   | admin           | admin |
      | User   | access_requests | admin |
    And I have the following FOR codes
      | subject_code | subject_name       |
      | 010112       | Topology           |
      | 040312       | Structural Geology |

    And I have a user "georgina@intersect.org.au"
    And "georgina@intersect.org.au" has role "admin"
    And I am logged in as "georgina@intersect.org.au"

  @javascript
  Scenario: Create Local Input Collection
    Given I have an experiment "Proteome"
    Given I am on the list experiments page
    And I follow "Edit"
    Then I should see "Input Collections"
    Then I follow "Add Collection"
    And I fill in "Name" with "Proteome Collection"
    And I add the FOR code "040312 - Structural Geology" in input collection
    And I select collection type "Local"
    And I press "Create Input Collection"

  @javascript
  Scenario: Create Remote Input Collection
    Given I have an experiment "Proteome - Remote"
    Given I am on the list experiments page
    And I follow "Edit"
    Then I should see "Input Collections"
    Then I follow "Add Collection"
    And I fill in "Name" with "Proteome Collection"
    And I add the FOR code "040312 - Structural Geology" in input collection
    And I select collection type "Remote"
    And I press "Create Input Collection"

  @javascript
  Scenario: Edit Input Collection
    Given I have an experiment "Proteome - Remote"
    Given I have an input collection for experiment "Proteome - Remote"
    Given I am on the list experiments page
    And I follow "Edit"
    Then I should see "Input Collections"
    Then I follow "Edit"
    And I fill in "Name" with "Genome Collection"
    And I press "Update Input Collection"

  @javascript
  Scenario: Show Input Collection
    Given I have an experiment "Proteome - Remote"
    Given I have an input collection for experiment "Proteome - Remote"
    Given I am on the list experiments page
    And I follow "Edit"
    Then I should see "Input Collections"
    Then I follow "Show"
    Then I should see "Proteome"
    And I should see "123456"

  @javascript
  Scenario: Delete Input Collection
    Given I have an experiment "Proteome - Remote"
    Given I have an input collection for experiment "Proteome - Remote"
    Given I am on the list experiments page
    And I follow "Edit"
    Then I should see "Input Collections"
    Then I follow "Delete"
    And I delete the experiment
    Then I should not see "Proteome - Remote"