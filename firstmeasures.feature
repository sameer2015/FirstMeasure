@javascript
Feature: DOer data feeding for Assessment & Benchmarking
  In order to feed data for Assessment & Benchmarking Survey 
  As a Customer
  I want to enter data for healthcare plans
   

 @first_login
 Scenario Outline: Doer should be able to login with new account and should be directed to complete the Customer Profile Info
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  And I click "Your data"
  When I select "2013" from "edit-field-year-und-0-value"
  Then I should see "December 2013"
  And I fill in "edit-field-health-plans-und-0-field-plan-name-group-und-0-field-plan-name-und-0-value" with "HealthCarePlan-A"
  And I fill in "edit-field-pharmacy-plans-und-0-field-pharmacy-plan-group-und-0-field-pharmacy-plan-name-und-0-value" with "PharmacyPlan-A"
  And I check "edit-field-programs-und-health-risk"
  And I check "edit-field-programs-und-health-screenings"
  And I check "edit-field-programs-und-wellness-programs"
  And I press "edit-submit"
  Then I should see "Your changes have been saved."

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

 @demographics
 Scenario Outline: As a customer, need to enter data for Section -Demographics and Benefits Offerings
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  And I click "Your data"
  Then I am at "/your-data"
  And I click "Demographics and Benefits Offerings"
  Then I should see "Payroll Information"
  And I wait
  When I click the xpath "DEMOGRAPHIC_START_SESSION"
  And I fill in "edit-field-total-employee-headcount-und-value" with "5000"
  And I fill in "edit-field-full-time-percentage-und-value" with "100"
  And I fill in "edit-field-health-care-eligible-und-value" with "5000"
  And I fill in "edit-field-health-care-enrolled-und-value" with "5000"
  And I fill in "edit-field-health-care-enrolled-dep-und-value" with "3000"
  And I fill in "edit-field-health-care-enrolled-ret-und-value" with "2000"
  And I fill in "edit-field-total-lives-und-value" with "10000"
  And I press "Next"
  Then I should see "Step 2 of 3"
  When I fill in "edit-field-percentage-enrolled-gender-und-value" with "50"
  And I fill in "edit-field-average-age-und-value" with "39"
  And I wait
  And I press the xpath "CLICK_NEXT"
  Then I should see "Step 3 of 3"
  When I fill in "edit-field-percentage-insured-funded-und-value" with "50"
  And I click the xpath "RADIO_YES"
  Then I should see "What is the amount at which coverage initiates?"
  When I fill in "edit-field-amount-coverage-initiates-und-value" with "10"
  And I click the xpath "RADIO_NO"
  And I press "Complete Section"
  Then I should see "12 of 12 questions completed"
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "Your data"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

@wellness
 Scenario Outline: As a customer, need to enter data for Section -Wellness Programs
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  And I click "Wellness Programs"
  Then I should see "Wellness Program Report and Plan Descriptions"
  And I should see "Disease Management Program Report and Plan Descriptions"
  And I wait
  When I click the xpath "WELLNESS_START_SESSION"
  Then I should see "Wellness Programs"
  When I click the xpath "WELLNESS_Q1_RADIO_YES"
  And I click the xpath "WELLNESS_Q2_RADIO_NO"
  And I click the xpath "WELLNESS_Q3_RADIO_NO"
  And I click the xpath "WELLNESS_Q4_RADIO_NO"
  And I fill in "edit-field-employee-particip-rate-und-value" with "55"
  And I check "edit-field-types-wellness-programs-und-value-weight-management"
  And I press "Complete Section"
  Then I should see "6 of 6 questions completed"
  And I should see "Nice work!"
  And I should see "You answered all questions in this section."
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "Your data"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

@hra
 Scenario Outline: As a customer, need to enter data for Section -Health Risk Assessment (HRA)
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  And I click "Health Risk Assessment (HRA)"
  Then I should see "Health Risk Assessment (HRA) Report/Summary or Health Questionnaire Report/Summary"
  And I wait
  When I click the xpath "HRA_START_SESSION"
  Then I should see "Health Risk Assessment (HRA)"
  When I click the xpath "HRA_Q1_RADIO_YES"
  And I click the xpath "HRA_Q2_RADIO_NO"
  And I select "Annual" from "edit-field-how-many-hra-administer-und-value"
  And I click the xpath "HRA_Q4_RADIO_NO"
  And I fill in "edit-field-employee-number-eligible-und-value" with "5000"
  And I fill in "edit-field-employee-number-completed-und-value" with "4000"
  And I click the xpath "HRA_Q7_RADIO_NO"
  And I press "Next"
  Then I should see "Step 2 of 3"
  When I click the xpath "HRA_Q8_RADIO_YES"
  And I click the xpath "HRA_Q9_RADIO_YES"
  And I wait
  And I fill in "edit-field-hra-following-bmi-und-value-0" with "33"
  And I fill in "edit-field-hra-following-bmi-und-value-1" with "33"
  And I fill in "edit-field-hra-following-bmi-und-value-2" with "34"
  And I fill in "edit-field-percentage-of-participants-und-value-0" with "20"
  And I fill in "edit-field-percentage-of-participants-und-value-1" with "20"
  And I fill in "edit-field-percentage-of-participants-und-value-2" with "20"
  And I fill in "edit-field-percentage-of-participants-und-value-3" with "30"
  And I fill in "edit-field-percentage-of-participants-und-value-4" with "10"
  And I fill in "edit-field-average-number-missed-days-und-value" with "2"
  And I press the xpath "HRA_NEXT"
  Then I should see "Step 3 of 3"
  And I fill in "edit-field-percentage-particip-report-und-value-0" with "20"
  And I fill in "edit-field-percentage-particip-report-und-value-1" with "20"
  And I fill in "edit-field-percentage-particip-report-und-value-2" with "90"
  And I fill in "edit-field-percentage-particip-report-und-value-3" with "90"
  And I fill in "edit-field-percentage-particip-report-und-value-4" with "90"
  And I fill in "edit-field-percentage-particip-report-und-value-5" with "70"
  And I fill in "edit-field-percentage-particip-report-und-value-6" with "3"
  And I fill in "edit-field-percentage-particip-report-und-value-7" with "3"
  And I fill in "edit-field-percentage-particip-report-und-value-8" with "0"
  And I fill in "edit-field-percentage-particip-report-und-value-9" with "0"
  And I fill in "edit-field-percentage-particip-report-und-value-10" with "0"
  And I fill in "edit-field-percentage-particip-report-und-value-11" with "0"
  And I fill in "edit-field-percentage-particip-report-und-value-12" with "20"
  And I fill in "edit-field-percentage-particip-report-und-value-13" with "2"
  And I fill in "edit-field-percentage-particip-report-und-value-14" with "98"
  And I fill in "edit-field-percentage-particip-report-und-value-15" with "5"
  And I fill in "edit-field-percentage-particip-report-und-value-16" with "5"
  And I fill in "edit-field-percentage-particip-report-und-value-17" with "6"
  And I fill in "edit-field-percentage-particip-report-und-value-18" with "7"
  And I fill in "edit-field-hra-preventive-service-und-value-0" with "50"
  And I fill in "edit-field-hra-preventive-service-und-value-1" with "50"
  And I fill in "edit-field-hra-preventive-service-und-value-2" with "40"
  And I fill in "edit-field-hra-preventive-service-und-value-3" with "40"
  And I press "Complete Section"
  Then I should see "13 of 13 questions completed"
  And I should see "Nice work!"
  And I should see "You answered all questions in this section."
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "Your data"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

@health_screenings
 Scenario Outline: As a customer, need to enter data for Section -Health Screenings
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  And I click "Health Screenings"
  Then I should see "Biometric Screening Report or Health Screening Report"
  And I wait
  When I click the xpath "HEALTH_SCREENING_START_SESSION"
  Then I should see "Health Screenings"
  When I click the xpath "HS_Q1_RADIO_MANAGE_INTERNALLY"
  And I select "Annual" from "edit-field-number-screening-employees-und-value"
  And I click the xpath "HS_Q3_RADIO_NO"
  And I fill in "edit-field-overall-participation-und-value" with "35"
  And I fill in "edit-field-particip-rate-by-gender-und-value" with "80"
  And I click the xpath "HS_Q6_RADIO_NO"
  And I click the xpath "HS_Q7_RADIO_NO"
  And I press "Next"
  Then I should see "Step 2 of 2"
  When I fill in "edit-field-hs-percent-bmi-und-value-0" with "33"
  And I fill in "edit-field-hs-percent-bmi-und-value-1" with "33"
  And I fill in "edit-field-hs-percent-bmi-und-value-2" with "34"
  And I fill in "edit-field-hs-percent-participants-und-value-0" with "0"
  And I fill in "edit-field-hs-percent-participants-und-value-1" with "0"
  And I fill in "edit-field-hs-percent-participants-und-value-2" with "0"
  And I fill in "edit-field-hs-percent-participants-und-value-3" with "0"
  And I fill in "edit-field-hs-percent-participants-und-value-4" with "0"
  And I fill in "edit-field-hs-percent-participants-und-value-5" with "0"
  And I fill in "edit-field-hs-percent-participants-und-value-6" with "0"
  And I fill in "edit-field-hs-percent-participants-und-value-7" with "0"
  And I press "Complete Section"
  Then I should see "9 of 9 questions completed"
  And I should see "Nice work!"
  And I should see "You answered all questions in this section."
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "Your data"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

@health_plan
Scenario Outline: As a customer, need to enter data for Section -Health Plan Information
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  And I click "Health Plan Information"
  Then I should see "Plan Summary Document, Benefit Summary Document, or Annual Health Plan Annual Utilization Summary Reports (Enrollment and Covered Lives)"
  And I should see "Health Plan Annual Utilization Summary Reports or Documents (This report could be a part of your Health Plan Summary)"
  And I wait
  When I click the xpath "HEALTHPLAN_INFO_START_SESSION"
  Then I should see "Health Plan Information"
  When I select "PPO" from "edit-field-hpi-type-of-plan-und-value"
  And I fill in "edit-field-hpi-number-enrolled-und-value" with "5000"
  And I fill in "edit-field-pi-covered-lives-n-und-value" with "10000"
  And I fill in "edit-field-hpi-indiv-annual-premium-und-value" with "7000"
  And I fill in "edit-field-hpi-individual-deductible-und-value" with "3000"
  And I fill in "edit-field-hpi-family-annual-premium-und-value" with "10000"
  And I fill in "edit-field-hpi-family-deductible-und-value" with "5000"
  And I fill in "edit-field-hpi-office-visit-copay-und-value" with "25"
  And I fill in "edit-field-hpi-sp-office-visit-copay-und-value" with "25"
  And I click the xpath "HP_Q6_RADIO_NO"
  And I press "Complete Section"
  Then I should see "6 of 6 questions completed"
  And I should see "Nice work!"
  And I should see "You answered all questions in this section."
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "Your data"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

@medical_claims
Scenario Outline: As a customer, need to enter data for Section -Medical Claims & Top Conditions
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  And I click "Medical Claims & Top Conditions"
  Then I should see "Health Plan Annual Utilization Summary Reports or Documents (This report could be a part of your Health Plan Summary)"
  And I wait
  When I click the xpath "MEDICAL_CLAIM_START_SESSION"
  Then I should see "Medical Claims & Top Conditions"
  When I click the xpath "MCTC_Q1_RADIO_NO"
  And I fill in "edit-field-mc-claim-cost-und-value" with "132000"
  And I fill in "edit-field-mc-number-of-claimants-und-value" with "4000"
  And I fill in "edit-field-mc-cost-for-the-plan-und-value" with "300"
  And I fill in "edit-field-mc-medical-cost-und-value" with "200"
  And I fill in "edit-field-mc-claimants-percentage-und-value" with "50"
  And I fill in "edit-field-mc-number-of-no-claims-und-value" with "6000"
  And I check "edit-field-mc-report-patients-und-save-later"
  And I press "Complete Section"
  Then I should see "7 of 8 questions completed"
  And I should see "You're making progress."
  And I should see "You've added 1 question from this section to Saved for Later."
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "You still have some unanswered questions"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

@pharmacy_plans
Scenario Outline: As a customer, need to enter data for Section -Pharmacy Plans
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  And I click "Pharmacy Plans"
  Then I should see "Pharmacy Plan Summary Document or Annual Pharmacy Plan Utilization Report (Either of these reports could be a part of your Health Plan Summary Report)"
  And I wait
  When I click the xpath "PHARMACY_PLANS_START_SESSION"
  Then I should see "Pharmacy Plans"
  When I select "1" from "edit-field-pp-cost-sharing-und-value"
  And I click the xpath "PP_Q2_COPAY"
  And I fill in "edit-field-pp-co-pay-number-und-value-0" with "20"
  And I fill in "edit-field-pp-co-pay-number-und-value-1" with "50"
  And I fill in "edit-field-pp-enrolled-employees-und-value" with "5000"
  And I fill in "edit-field-pp-total-covered-lives-und-value" with "10000"
  And I click the xpath "PP_Q5_RADIO_YES"
  And I wait
  And I click the xpath "PP_Q5_DEPENDENT_YES"
  And I press "Complete Section"
  Then I should see "5 of 5 questions completed"
  And I should see "Nice work!"
  And I should see "You answered all questions in this section."
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "You still have some unanswered questions"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

@pharmacy_claims
Scenario Outline: As a customer, need to enter data for Section -Pharmacy Claims
  Given I am at "/user"
  When I fill in "edit-name" with "<USER>"
  And I fill in "edit-pass" with "<PWD>"
  And I press "edit-submit"
  Then I am at "/dashboard" 
  When I click the xpath "CONTINUE_ENTERING_DATA"
  And I click "Pharmacy Claims"
  Then I should see "Pharmacy Plan Summary Documents, Annual Pharmacy Plan Utilization Report (This report could be a part of your Health Plan Summary)"
  And I wait
  When I click the xpath "PHARMACY_CLAIMS_START_SESSION"
  Then I should see "Pharmacy Claims"
  When I fill in "edit-field-pcf-total-costs-for-plan-und-value" with "160000"
  And I fill in "edit-field-pcf-coverd-without-claims-und-value" with "3000"
  And I fill in "edit-field-pcf-member-cost-per-month-und-value" with "560000"
  And I fill in "edit-field-pcf-percent-sp-med-costs-und-value" with "80"
  And I fill in "edit-field-pcf-avg-num-per-claimant-und-value" with "12"
  And I fill in "edit-field-pcf-gen-fill-rate-und-value" with "12"
  And I fill in "edit-field-pcf-gen-fill-efficienty-und-value" with "12"
  And I press "Next"
  Then I should see "Step 2 of 2"
  When I fill in "edit-field-pcf-10-most-common-und-value-0" with "ALDOSTERONE ANTAGONISTS"
  And I fill in "edit-field-pcf-num-scripts-und-value-0" with "1000"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-0" with "1000"

  And I fill in "edit-field-pcf-10-most-common-und-value-1" with "AMPHETAMINE PREPARATIONS"
  And I fill in "edit-field-pcf-num-scripts-und-value-1" with "900"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-1" with "900"
  
  And I fill in "edit-field-pcf-10-most-common-und-value-2" with "ANTIFUNGALS"
  And I fill in "edit-field-pcf-num-scripts-und-value-2" with "800"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-2" with "800"

  And I fill in "edit-field-pcf-10-most-common-und-value-3" with "SEDATIVE BARBITURATE"
  And I fill in "edit-field-pcf-num-scripts-und-value-3" with "700"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-3" with "700"

  And I fill in "edit-field-pcf-10-most-common-und-value-4" with "ANALGESICS - OPIOID"
  And I fill in "edit-field-pcf-num-scripts-und-value-4" with "600"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-4" with "600"

  And I fill in "edit-field-pcf-10-most-common-und-value-5" with "ANTIPARKINSON"
  And I fill in "edit-field-pcf-num-scripts-und-value-5" with "500"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-5" with "500"

  And I fill in "edit-field-pcf-10-most-common-und-value-6" with "DIABETES THERAPY"
  And I fill in "edit-field-pcf-num-scripts-und-value-6" with "400"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-6" with "400"

  And I fill in "edit-field-pcf-10-most-common-und-value-7" with "FLUOROQUINOLONES"
  And I fill in "edit-field-pcf-num-scripts-und-value-7" with "300"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-7" with "300"

  And I fill in "edit-field-pcf-10-most-common-und-value-8" with "DIURETICS AND AQUARETICS"
  And I fill in "edit-field-pcf-num-scripts-und-value-8" with "200"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-8" with "200"

  And I fill in "edit-field-pcf-10-most-common-und-value-9" with "RAUWOLFIAS"
  And I fill in "edit-field-pcf-num-scripts-und-value-9" with "100"
  And I fill in "edit-field-pcf-total-cost-scripts-und-value-9" with "100"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-0" with "ALDOSTERONE ANTAGONISTS"
  And I fill in "edit-field-total-cost-expensive-und-value-0" with "1000"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-0" with "1000"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-1" with "ANTIFUNGALS"
  And I fill in "edit-field-total-cost-expensive-und-value-1" with "900"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-1" with "900"
  
  And I fill in "edit-field-pcf-10-most-expensive-und-value-2" with "AMINOGLYCOSIDES"
  And I fill in "edit-field-total-cost-expensive-und-value-2" with "800"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-2" with "800"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-3" with "AMPHETAMINE PREPARATIONS"
  And I fill in "edit-field-total-cost-expensive-und-value-3" with "700"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-3" with "700"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-4" with "ANTI-INFECTIVES SYSTEMIC"
  And I fill in "edit-field-total-cost-expensive-und-value-4" with "600"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-4" with "600"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-5" with "ATARACTICS-TRANQUILIZERS"
  And I fill in "edit-field-total-cost-expensive-und-value-5" with "500"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-5" with "500"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-6" with "DIURETICS AND AQUARETICS"
  And I fill in "edit-field-total-cost-expensive-und-value-6" with "400"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-6" with "400"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-7" with "FLUOROQUINOLONES"
  And I fill in "edit-field-total-cost-expensive-und-value-7" with "300"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-7" with "300"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-8" with "RAUWOLFIAS"
  And I fill in "edit-field-total-cost-expensive-und-value-8" with "200"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-8" with "200"

  And I fill in "edit-field-pcf-10-most-expensive-und-value-9" with "ENZYMES"
  And I fill in "edit-field-total-cost-expensive-und-value-9" with "100"
  And I fill in "edit-field-pcf-num-expensive-scripts-und-value-9" with "100"

  And I press "Complete Section"
  Then I should see "Nice work!"
  And I should see "You answered all questions in this section."
  When I click the xpath "BACK_TO_DASHBOARD"
  Then I should see "You still have some unanswered questions"

  Examples:
  |USER|PWD|
  |dev3mosv-c2|Test@345|

 