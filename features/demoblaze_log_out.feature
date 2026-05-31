Feature: Demoblaze user log out
              As a demo user
              I want to log out of the user session
    So that I can test the log out functionality of the user logged

        Background:
            Given I browse to Demoblaze page
              And I am logged in with a registered user

        @demoblaze_log_out
        Scenario: Log out functionality of a logged user
             When I click on the "Log out" option
             Then the home page should be displayed
              And the option "Log out" should change to "Log in"
              And the option "Welcome [user]" should change to "Sign up"