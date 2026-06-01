Feature: Demoblaze successful contact form submission
              As a demo user
              I want to send a message through the Contact form
  So that I can validate that the contact modal works correctly

        Background:
            Given I browse to Demoblaze page

        @contact_success_data_table
        Scenario: Send contact message successfully using data table
             When I open the Contact modal for successful message test
             Then the Contact modal should be displayed for successful message test
             When I fill the Contact form with:
                  | Email   | qa.tester@test.com         |
                  | Name    | QA Tester Ariel            |
                  | Message | This is an automated test. |
              And I click the Send message button for successful contact test
             Then the Contact alert message should be "Thanks for the message!!"