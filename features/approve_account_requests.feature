Feature: Approve access requests
  In order to allow users to access the system
  As an administrator
  I want to approve access requests

  Background:
    Given I have roles
      | name       |
      | admin  |
      | Researcher |
    And I have permissions
      | entity | action          | roles  |
      | User   | read            | admin |
      | User   | admin           | admin |
      | User   | reject          | admin |
      | User   | approve         | admin |
    And I have a user "georgina@intersect.org.au" with role "admin"
    And I have access requests
      | email                  | first_name | last_name        |
      | ryan@intersect.org.au  | Ryan       | Braganza         |
      | diego@intersect.org.au | Diego      | Alonso de Marcos |
    And I am logged in as "georgina@intersect.org.au"

  Scenario: View a list of access requests
    Given I am on the access requests page
    Then I should see "access_requests" table with
      | First name | Last name        | Email                  |
      | Diego      | Alonso de Marcos | diego@intersect.org.au |
      | Ryan       | Braganza         | ryan@intersect.org.au  |

  Scenario: Approve an access request from the list page
    Given I am on the access requests page
    When I follow "Approve" for "diego@intersect.org.au"
    And I select "admin" from "Role"
    And I press "Approve"
    Then I should see "The access request for diego@intersect.org.au was approved."
    And I should see "access_requests" table with
      | First name | Last name | Email                 |
      | Ryan       | Braganza  | ryan@intersect.org.au |
    And "diego@intersect.org.au" should receive an email with subject "ap11 - Your access request has been approved"
    When they open the email
    Then they should see "You made a request for access to the ap11 System. Your request has been approved. Please visit" in the email body
    And they should see "Hello Diego Alonso de Marcos," in the email body
    When they click the first link in the email
    Then I should be on the home page

  Scenario: Cancel out of approving an access request from the list page
    Given I am on the access requests page
    When I follow "Approve" for "diego@intersect.org.au"
    And I select "admin" from "Role"
    And I follow "Back"
    Then I should be on the access requests page
    And I should see "access_requests" table with
      | First name | Last name        | Email                  |
      | Diego      | Alonso de Marcos | diego@intersect.org.au |
      | Ryan       | Braganza         | ryan@intersect.org.au  |

  Scenario: View details of an access request
    Given I am on the access requests page
    When I follow "View Details" for "diego@intersect.org.au"
    Then I should see "user" table with
      | Email          | diego@intersect.org.au |
      | First name     | Diego                  |
      | Last name      | Alonso de Marcos       |
      | Last logged in |                        |
      | Role           |                        |
      | Status         | Pending Approval       |
      | Home page      |                        |
      | Description    |                        |
      | FOR code(s)    |                        |

  Scenario: Approve an access request from the view details page
    Given I am on the access requests page
    When I follow "View Details" for "diego@intersect.org.au"
    And I follow "Approve"
    And I select "admin" from "Role"
    And I press "Approve"
    Then I should see "The access request for diego@intersect.org.au was approved."
    And I should see "access_requests" table with
      | First name | Last name | Email                 |
      | Ryan       | Braganza  | ryan@intersect.org.au |

  Scenario: Cancel out of approving an access request from the view details page
    Given I am on the access requests page
    When I follow "View Details" for "diego@intersect.org.au"
    And I follow "Approve"
    And I select "admin" from "Role"
    And I follow "Back"
    Then I should be on the access requests page
    And I should see "access_requests" table with
      | First name | Last name        | Email                  |
      | Diego      | Alonso de Marcos | diego@intersect.org.au |
      | Ryan       | Braganza         | ryan@intersect.org.au  |

  Scenario: Go back to the access requests page from the view details page without doing anything
    Given I am on the access requests page
    And I follow "View Details" for "diego@intersect.org.au"
    When I follow "Back"
    Then I should be on the access requests page
    And I should see "access_requests" table with
      | First name | Last name        | Email                  |
      | Diego      | Alonso de Marcos | diego@intersect.org.au |
      | Ryan       | Braganza         | ryan@intersect.org.au  |

  Scenario: Role should be mandatory when approving an access request
    Given I am on the access requests page
    When I follow "Approve" for "diego@intersect.org.au"
    And I press "Approve"
    Then I should see "Please select a role for the user."

  Scenario: Approved user should be able to log in
    Given I am on the access requests page
    When I follow "Approve" for "diego@intersect.org.au"
    And I select "admin" from "Role"
    And I press "Approve"
    And I am on the home page
    And I follow "Logout"
    Then I should be able to log in with "diego@intersect.org.au" and "Pas$w0rd"

  Scenario: Approved user roles should be correctly saved
    Given I am on the access requests page
    And I follow "Approve" for "diego@intersect.org.au"
    And I select "admin" from "Role"
    And I press "Approve"
    And I am on the list users page
    When I follow "View Details" for "diego@intersect.org.au"
    Then I should see "user" table with
      | Email          | diego@intersect.org.au |
      | First name     | Diego                  |
      | Last name      | Alonso de Marcos       |
      | Last logged in | Never logged in        |
      | Role           | admin                  |
      | Status         | Active                 |
      | Home page      |                        |
      | Description    |                        |
      | FOR code(s)    |                        |
