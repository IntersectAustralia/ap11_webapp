Feature: Creating new party records
  In order to create parties for input collections
  As a user
  I want to have a form for creating new parties

  Background:
    Given I have a user "georgina@intersect.org.au"
    And I am on the login page
    And I am logged in as "georgina@intersect.org.au"


  Scenario: Check all form fields are present
    Given I am on the create party records page
    Then I should see "New Input collection"
    And I should see "Abbreviation"
    And I should see "Full Name"
    And I should see "Full Name"
    And I should see "Description"
    And I should see "Address"
    And I should see "URL"
    And I should see "FOR Code 1 (Optional)"
    And I should see "FOR Code 2 (Optional)"
    And I should see "FOR Code 3 (Optional)"
    And I should see "Default Access Rights"
    And I should see "Default License"
