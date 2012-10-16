Feature: Creating new party records
  In order to create parties for input collections
  As a user
  I want to have a form for creating new parties

  Background:
    Given I have the usual roles and permissions
    Given I have a user "georgina@intersect.org.au" with role "admin"
    And I am on the login page
    And I am logged in as "georgina@intersect.org.au"

  Scenario: Check all form fields are present
    Given I am on the create party record page
    Then I should see "New Party Record"
    And I should see "Abbreviation"
    And I should see "Full name"
    And I should see "Description"
    And I should see "Address"
    And I should see "URL"
    And I should see "FOR code 1 (optional)"
    And I should see "FOR code 2 (optional)"
    And I should see "FOR code 3 (optional)"
    And I should see "Default access rights"
    And I should see "Default license"

  Scenario: Create party record
    Given I am on the home page
    Then I should see "Party Records Management"
    And I follow "Party Records Management"
    Then I should see "Listing party records"
    And I follow "New Party Record"
    Then I should be on the create party record page
    And I fill in "Abbreviation" with "Short123"
    And I fill in "Full name" with "Long Party Record 12345"
    And I fill in "Description" with "Sample description"
    And I fill in "Address" with "35 Green Street Sydney NSW Australia 2000"
    And I fill in "URL" with "www.intersect.org.au"
    And I fill in "Default access rights" with "sample rights"
    And I fill in "Default license" with "sample license"
    And I press "Create Party Record"
    Then I should see "Party record was successfully created."
    And I should see "Short123"
    And I should see "Long Party Record 12345"

  Scenario: Edit party record
    Given I am on the home page
    And I have party records
    | abbreviation | full_name | description |
    | pr1 | party record 1 | myDescription |
    | pr2 | party record 2 | myDescription |
    And I follow "Party Records Management"
    Then I should see "Listing party records"
    And I should see "pr1"
    And I should see "party record 1"
    And I follow "Edit"
    And I fill in "Abbreviation" with "new_abbreviation"
    And I fill in "Full name" with "new_name"
    And I press "Edit Party Record"
    Then I should see "Party record was successfully updated."
    And I should see "new_abbreviation"
    And I should see "new_name"

  Scenario: Show party record
    Given I am on the home page
    And I have party records
    | abbreviation | full_name | description |
    | pr1 | party record 1 | myDescription |
    And I follow "Party Records Management"
    And I follow "Show"
    And I should see "pr1"
    And I should see "party record 1"
    And I should see "myDescription"
    And I should see "MyText"
    And I should see "MyString"


  Scenario: Delete experiment
    Given I am on the home page
    And I have party records
    | abbreviation | full_name | description |
    | pr1 | party record 1 | myDescription |
    And I follow "Party Records Management"
    And I follow "Delete"
    And I delete the party record
    Then I should see "Listing party records"
    Then I should not see "pr1"