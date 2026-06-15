Feature: Demoblaze Contact form
  As a visitor
  I want to send messages through the contact form
  So that I can communicate with the store

  Background:
    Given I am on the Demoblaze home page

  @contact_empty_fields_validation
  Scenario: Send message with empty fields
    When I open the contact form
    Then I can see the contact window
    When I send the message without filling any field
    Then I see a message telling me to complete the form

  @smoke_test_contact_bug_report
  Scenario: Contact form saves information after closing
    When I open the contact form
    Then I can see the contact window
    When I write my name as "QA Tester Ariel"
    And I close the window
    When I open the contact form again
    Then my name should still be "QA Tester Ariel"
    When I write my email as "ariel@test.com"
    And I close the window using the X button
    When I open the contact form again
    Then my name should still be "QA Tester Ariel"
    And my email should still be "ariel@test.com"
    When I write a message saying "I found a problem"
    And I send the message
    Then I see a confirmation saying "Thanks for the message!!"

  @contact_success
  Scenario: Send message successfully
    When I open the contact form
    Then I can see the contact window
    When I fill the contact form with:
      | Email   | qa.tester@test.com |
      | Name    | QA Tester Ariel    |
      | Message | This is an automated test |
    And I send the message
    Then I see a confirmation saying "Thanks for the message!!"