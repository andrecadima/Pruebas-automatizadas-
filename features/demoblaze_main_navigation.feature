Feature: Demoblaze main menu options
  As a shopper
  I want to use the main menu options
  So that I can navigate to different sections of the store

  Background:
    Given I am on the Demoblaze home page

  @main_navigation_validation
  Scenario Outline: Navigate using the main menu
    When I click on "<menu_option>" from the menu
    Then I see the "<menu_option>" section

    Examples:
      | menu_option |
      | Home        |
      | Contact     |
      | About us    |
      | Cart        |
      | Log in      |
      | Sign up     |