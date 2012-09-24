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
