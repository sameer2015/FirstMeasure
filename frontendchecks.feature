@javascript
Feature: First Measures Homepage
  In order to track and maintain the reports of the services and programs offered by any health care company 
  As a Administrator of health plans at a company
  I want A system that manages the data for healthcare plans
   
@read_more
Scenario: The option to Read More should direct to /about page
  Given I am on the homepage
  When I click "Read More"
  Then I should be on "https://pffirstmeasdev3.prod.acquia-sites.com/about"

@login
Scenario Outline: User login from /user page
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I should see "Dashboard"
  Examples:
  |USER|PWD|
  |dev3mosu|test1234|

@chk_aft_submission
Scenario Outline: As a customer, relogin after submission of Phase1 to confirm the dashboard
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  And I should see "Thank you for submitting your data."

  Examples:
  |USER|PWD|
  |dev3mosu-c1|test1234|