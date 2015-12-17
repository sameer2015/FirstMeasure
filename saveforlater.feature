@javascript
Feature: DOer answering Saved for Later questions for Assessment & Benchmarking
  In order to answer those questions which are marked as Saved for Later
  As a Customer
  I want to revise and submit data for healthcare plans
   

 @sfl
Scenario Outline: As a customer, need to enter data for those questions which are marked for SFL
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  Then I should see "Resolve Saved For Later"
  When I click "Resolve Saved For Later"
  And I wait
  And I click the xpath "MCTC_Q8_RADIO_YES"
  And I select "We do not collect these data" from "edit-field-mc-report-patients-und-more"
  And I wait
  And I wait
  Then I should see "You have no questions saved."

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|