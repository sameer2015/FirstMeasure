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
  When I fill in "edit-name" with "<USERNAME>"
  And I fill in "edit-pass" with "<PASSWORD>"
  And I press "edit-submit"
  Then I should see "Dashboard"

  Examples:
  |USERNAME|PASSWORD|
  |dev3mosq|test1234|
  |dev4mosq|test1234|

@create_new_customer
Scenario: User login from /user page
  Given I am at "/user"
  When I fill in "edit-name" with "dev3mosq"
  And I fill in "edit-pass" with "test1234"
  And I press "edit-submit"
  Then I should see "Welcome"

  When I go to "/admin/companies/add"
  And I wait
  And I fill in "edit-name" with "DEV3-MOSQ-SS4"
  And I fill in "edit-field-location-zip-und-0-postal" with "10583"
  And I fill in "Publicly Traded" for "edit-field-sector-und"
  And I fill in "edit-field-auto-industry-code-und-0-tid" with "21 Mining"
  And I fill in "edit-field-customer-team-members-und-0-field-email-address-und-0-value" with "sameersawant+dev3mosq-c4@appnovation.com"
  And I fill in "edit-field-customer-team-email-domain-und-0-value" with "appnovation.com"
  And I press "edit-submit"
  Then I should see "Your company's profile has been created"

 @first_login
 Scenario: Doer should be able to login with new account and should be directed to complete the Customer Profile Info
  Given I am at "/user"
  When I fill in "edit-name" with "dev3mosq-c4"
  And I fill in "edit-pass" with "test1234"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  And I click "Your data"
  Then I am at "/admin/companies/manage/336?destination=your-data"
  And I select "2014" from "edit-field-year-und-0-value"
  Then I should see "December 2014"
  And I fill in "edit-field-health-plans-und-0-field-plan-name-group-und-0-field-plan-name-und-0-value" with "HealthCarePlan-A"
  And I fill in "edit-field-pharmacy-plans-und-0-field-pharmacy-plan-group-und-0-field-pharmacy-plan-name-und-0-value" with "PharmacyPlan-A"
  And I check "edit-field-programs-und-health-risk"
  And I check "edit-field-programs-und-health-screenings"
  And I check "edit-field-programs-und-wellness-programs"
  And I press "edit-submit"
  Then I should see "Your changes have been saved."

 @navigation_checks
 Scenario: Doer should be able to login and complete Wellness Program section from Phase1
  Given I am at "/user"
  When I fill in "edit-name" with "dev3mosq-c4"
  And I fill in "edit-pass" with "test1234"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  And I click "Your data"
  Then I am at "/your-data"
  And I click "Wellness Programs"
  Then I should see "Wellness Program Report and Plan Descriptions"
  And I wait
  And I click the xpath "WELLNESS_PROGRAM_START_THIS_SESSION"
  And I click "Save & Exit"
  Then I am at "/your-data"
  And I click "Demographics and Benefits Offerings"
  Then I should see "Benefits and Enrollment in Health Care Plans"
  And I click "Start this section"
  Then I am at "/demographics"
  And I click "Save & Exit"
  Then I am at "/your-data"

 @error
 Scenario: Example
  Given I am at "/user"
  And I click the element with CSS selector "html.js.no-touch body.html.not-front.logged-in.no-sidebars.page-your-data.your-data-expand-processed.tourWindows-processed div#main.main-content div#block-system-main.block.block-system.block-system-main div.content div.panel-display.panel-2col.clearfix div.panel-panel.panel-col-first div.inside div.panel-pane.pane-block.pane-fm-your-data-page-form-program-elements div.pane-content div.overall-data div.program-wrapper div.data-text a"
  Then I am at "/wellness-programs"
  When I click ".//a[text()='Health Screenings']/following::a[contains(text(),'Start')][1]"
  And I click ".//*[@id='block-system-main']/div/div/div[1]/div/div[3]/div/div[1]/div[5]/div[2]/a"
  Then I am at "/wellness-programs"
