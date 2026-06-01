Feature: Demoblaze contact form empty fields validation
              As a demo user
              I want to submit the Contact form with empty fields
  So that I can validate how the system handles missing contact information

        Background:
            Given I browse to Demoblaze page

        @contact_empty_fields_validation
        Scenario: Send contact form with empty fields
             When I open the Contact modal for empty fields test
             Then the Contact modal should be displayed for empty fields test
             When I leave the Contact form fields empty
              And I click the Send message button for empty fields contact test
             Then the system should handle the empty Contact form submission