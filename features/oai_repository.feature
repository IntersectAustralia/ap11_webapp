Feature: Harvesting OAI records
  In order to harvest party and collection records
  As a user
  I want to have a page to harvest the records

  Background:
    Given I have an experiment "Proteome"
    And I have an input collection for experiment "Proteome"

  Scenario: Engine is mounted
    Given I am on the OAI repository page
    Then I should see "Value of the verb argument is not a legal OAI-PMH verb, the verb argument is missing, or the verb argument is repeated."
