Feature: Demoblaze logout functionality

        Background:
            Given I browse to Demoblaze page
              And I am logged in with a registered user

        @logout_validation
        Scenario: Successful logout from Demoblaze
             Then the welcome message should be visible before logout
             When I click on Log out for logout validation
             Then the Log in option should be visible after logout
              And the Sign up option should be visible after logout
              And the welcome message should not be visible after logout