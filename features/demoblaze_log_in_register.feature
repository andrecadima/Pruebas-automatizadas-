Feature: Demoblaze user registration and login
  As a demo user
  I want to create an account and log in
  So that I can test the sign up and sign in functionality

Background:
  Given I browse to Demoblaze page

@demoblaze_signup
Scenario: Successful sign up in Demoblaze
  When I click on "Sign up" option
  And I enter the registered username in the sign up username field
  And I enter the registered password in the sign up password field
  And I click on the "Sign up" button in the pop up
  Then the alert message should be "Sign up successful."

@demoblaze_signin
Scenario: Successful sign in in Demoblaze
  When I click on "Log in" option
  And I enter the registered username in the log in username field
  And I enter the registered password in the log in password field
  And I click on the "Log in" button in the pop up
  Then the welcome message should show the registered username
  


