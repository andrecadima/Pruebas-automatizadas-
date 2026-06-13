Feature: Demoblaze product filtering by category
  As a shopper
  I want to see products by category
  So that I can browse phones, laptops or monitors easily

  Background:
    Given I am on the Demoblaze home page

  @demoblaze_phones_filter
  Scenario Outline: See phones after selecting the Phones category
    Given I see the product "Samsung galaxy s6" on the page
    When I select the "Phones" category
    Then I stay on the home page
    And I see the product "<product_name>" in the list

    Examples:
      | product_name     |
      | Nokia lumia 1520 |
      | Nexus 6          |

  @demoblaze_laptops_filter
  Scenario Outline: See laptops after selecting the Laptops category
    Given I see the product "Samsung galaxy s6" on the page
    When I select the "Laptops" category
    Then I stay on the home page
    And I see the product "<product_name>" in the list

    Examples:
      | product_name |
      | Sony vaio i5 |
      | Sony vaio i7 |

  @demoblaze_monitors_filter
  Scenario Outline: See monitors after selecting the Monitors category
    Given I see the product "Samsung galaxy s6" on the page
    When I select the "Monitors" category
    Then I stay on the home page
    And I see the product "<product_name>" in the list

    Examples:
      | product_name     |
      | Apple monitor 24 |
      | ASUS Full HD     |