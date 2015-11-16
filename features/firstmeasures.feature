@javascript
Feature: First Measures Homepage
  In order to confirm basic navigation on their homepage
  As a anonymous user
  I want to track Read More option on hompage directs to desired page
   

@read_more
Scenario: The option to Read More should direct to /about page
  Given I am on the homepage
  When I click "Read More"
  Then I should see "About First Measures"

