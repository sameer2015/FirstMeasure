@javascript
Feature: First Measures MOS Activities
  In order to help companies understand their health care offerings and how they are utilized by employees
  As a Pfizer medical Admin user
  I want to review data, generate the reports and upload them for customer viewing. Also help customer to move through each phase of the survey process

@gen_submit
Scenario Outline: As an Admin, reviews collected data and submit those inputs to generate report
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I should see "Dashboard"
  When I click the xpath "REVIEW_COMP1"
  Then I should see "DEV3-MOSV-SS1"
  When I click the xpath "TRENDS_AND_REPORTS"
  Then I should see "Reports"
  When I click the xpath "REPORTS"
  Then I should see "Customer must answer all Phase 1 questions before you can upload the Phase 1 Report"
  When I click the xpath "UPLOAD_PHASE1_REPORT"
  Then I should see "Upload Phase 1 Report"
  When I attach the file "FirstMeasures_Assessment_and_Benchmarking_Report_DEV3-MOSV-SS1.pdf" to "droppable-field-report-file-und-0"
  Then I should see "REMOVE"
  When I click the xpath "UPLOAD_REPORT"
  Then I should see "Reports"

Examples:
  |USER|PWD|
  |dev3mosv|Test@123|
