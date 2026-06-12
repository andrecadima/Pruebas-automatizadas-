Feature: Demoblaze Contact form
  As a user
  I want to interact with the Contact form
  So that I can validate its behavior, persistence bugs, and successful submission

  Background:
    Given I browse to Demoblaze page

  @contact_empty_fields_validation
  Scenario: Send contact form with empty fields
    When I click on "Contact" option
    Then the contact modal should be displayed
    When I click the "Send message" button in the contact modal
    Then the system should handle the empty Contact form submission

  @smoke_test_contact_bug_report
  Scenario: Contact modal persists data after close and allows bug reporting
    When I click on "Contact" option
    Then the contact modal should be displayed
    When I fill in the contact name with "QA Tester Ariel"
    And I click the "Close" button in the contact modal
    When I click on "Contact" option
    Then the contact name field should contain "QA Tester Ariel"
    When I fill in the contact email with "ariel@test.com"
    And I click the "X" button in the contact modal
    When I click on "Contact" option
    Then the contact name field should contain "QA Tester Ariel"
    And the contact email field should contain "ariel@test.com"
    When I fill in the contact message with "Tienen un bug: se puede hacer una orden con el carrito vacío"
    And I click the "Send message" button in the contact modal
    Then the alert message should be "Thanks for the message!!"

  @contact_success_data_table
  Scenario: Send contact message successfully
    When I click on "Contact" option
    Then the contact modal should be displayed
    When I fill in the contact email with "qa.tester@test.com"
    And I fill in the contact name with "QA Tester Ariel"
    And I fill in the contact message with "This is an automated test."
    And I click the "Send message" button in the contact modal
    Then the alert message should be "Thanks for the message!!"