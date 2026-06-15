Feature: Demoblaze user registration, login and logout
  As a demo user
  I want to create an account, log in, and log out
  So that I can test the full authentication functionality

  Background:
    Given I browse to Demoblaze page

  @demoblaze_signup
  Scenario: Successful sign up in Demoblaze
    When I click on "Sign up" option
    And I enter a new random username in the sign up username field
    And I enter a new random password in the sign up password field
    And I click on the "Sign up" button in the pop up
    Then the alert message should be "Sign up successful."

  @smoke @demoblaze_signin
  Scenario: Successful sign in in Demoblaze
    When I click on "Log in" option
    And I enter the registered username in the log in username field
    And I enter the registered password in the log in password field
    And I click on the "Log in" button in the pop up
    Then the welcome message should show the registered username

  @logout_validation
  Scenario: Successful logout from Demoblaze
    Given I am logged in with a registered user
    Then the welcome message should be visible before logout
    When I click on "Log out" option
    Then the Log in option should be visible after logout
    And the Sign up option should be visible after logout
    And the welcome message should not be visible after logout