@javascript
Feature: DOer submit the data entered for Assessment & Benchmarking
  In order to submit the data feed for Phase1
  As a Customer
  I want to click and submit data for healthcare plans
   
@submission
Scenario Outline: As a customer, need to enter data for those questions which are marked for SFL
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  Then I should see "Nice work, you're ready to submit your data."
  When I press "edit-submit"
  Then I should see "Thank you for submitting your data."
  And I should see "The FirstMeasures team will review your data and compile your Assessment & Benchmarking Report. We will schedule a meeting with you when the report is ready."
  And I should see "Professional Development"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|