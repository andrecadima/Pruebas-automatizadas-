Feature: Demoblaze main navigation validation
              As a demo user
              I want to validate the main menu options
  So that I can confirm that each navigation option responds correctly

        Background:
            Given I browse to Demoblaze page

        @main_navigation_validation
        Scenario Outline: Validate main navigation menu option
             When I click the "<menu_option>" main navigation option
             Then the "<menu_option>" main navigation result should be displayed

        Examples:
                  | menu_option |
                  | Home        |
                  | Contact     |
                  | About us    |
                  | Cart        |
                  | Log in      |
                  | Sign up     |