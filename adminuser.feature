@javascript
Feature: First Measures MOS Activities
  In order to help companies understand their health care offerings and how they are utilized by employees
  As a Pfizer medical Admin user
  I want to create new customer

@create_new_customer
Scenario Outline: Admin invites and creates new customer
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I should see "Dashboard"

  When I go to "/admin/companies/add"
  And I wait
  And I fill in "edit-name" with "<ORG-NAME>"
  And I fill in "edit-field-location-zip-und-0-postal" with "10583"
  And I fill in "Publicly Traded" for "edit-field-sector-und"
  And I fill in "edit-field-auto-industry-code-und-0-tid" with "21 Mining"
  And I fill in "edit-field-customer-team-members-und-0-field-email-address-und-0-value" with "<CUST-EMAIL>"
  And I fill in "edit-field-customer-team-email-domain-und-0-value" with "appnovation.com"
  And I press "edit-submit"
  Then I should see "Your company's profile has been created"

  Examples:
  |USER|PWD|ORG-NAME|CUST-EMAIL|
  |dev3mosv|Test@123|DEV3-MOSV-SS2|sameersawant+dev3mosv-c2@appnovation.com|
