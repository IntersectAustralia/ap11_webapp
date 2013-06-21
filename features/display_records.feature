Feature: Displaying records that are published to ands
  In order to show more information on published items
  As a user
  I want to see more info

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

  Scenario: See information for published input collection
    Given I have an experiment "some experiment"
    Given I have an input collection called "Input1" for experiment "some experiment"
    Given I publish an experiment "some experiment"
    Given I visit input collection page for "Input1" for experiment "some experiment"
    Then I should see "Input1"
    And I should see "123456"
    And I should not see "Edit Input Collection"


  Scenario: I shouldn't see information for not published input collection
    Given I have an experiment "some experiment"
    Given I have an input collection called "Input1" for experiment "some experiment"
    Given I visit input collection page for "Input1" for experiment "some experiment"
    Then I should not see "Input1"
    And I should not see "123456"
    And I should not see "Edit Input Collection"


  Scenario: See information for published output collection
    Given I have an experiment "some experiment"
    Given I have an output collection called "Output1" for experiment "some experiment"
    Given I publish an experiment "some experiment"
    Given I visit output collection page for "Output1" for experiment "some experiment"
    Then I should see "Output1"
    And I should not see "Edit Output Collection"


  Scenario: I shouldn't see information for not published output collection
    Given I have an experiment "some experiment"
    Given I have an output collection called "Output1" for experiment "some experiment"
    Given I visit output collection page for "Output1" for experiment "some experiment"
    Then I should not see "Output1"
    And I should not see "Edit Output Collection"

  Scenario: See information for published service
    Given I have an service "some service"
    And I publish a service "some service"
    Given I visit service page for "some service"
    Then I should see "some service"


  Scenario: I shouldn't see information for not published service
    Given I have an service "some service"
    Given I visit service page for "some service"
    Then I should not see "some service"

  Scenario: See information for published user
    Given I have an experiment "some experiment"
    Given I have an output collection called "Output1" for experiment "some experiment"
    Given I publish an experiment "some experiment"
    Given I visit user page for "experiment@test.com"
    Then I should see "experiment@test.com"

  Scenario: I shouldn't see information for not published user
    Given I have an experiment "some experiment"
    Given I have an output collection called "Output1" for experiment "some experiment"
    Given I visit user page for "experiment@test.com"
    And I should not see "experiment@test.com"

  Scenario: See information for published party record
    Given I have an experiment "some experiment"
    Given I have an input collection "Input1" for experiment "some experiment" for party record "My sample party record"
    Given I publish an experiment "some experiment"
    Given I visit party record page for description "My sample party record"
    Then I should see "My sample party record"

  Scenario: I shouldn't see information  for not published party record
    Given I have an experiment "some experiment"
    Given I have an input collection "Input1" for experiment "some experiment" for party record "My sample party record"
    Given I visit party record page for description "My sample party record"
    Then I should not see "My sample party record"
