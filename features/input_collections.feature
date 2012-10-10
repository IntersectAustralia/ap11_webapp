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

  Scenario: Edit Input Collection

  Scenario: Show Input Collection

  Scenario: Delete Input Collection