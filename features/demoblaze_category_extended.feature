Feature: Demoblaze extended category filtering
              As a demo user
              I want to validate products by category
  So that I can confirm that the product filters work correctly

        Background:
            Given I browse to Demoblaze page

        @category_extended_filter
        Scenario Outline: Validate expected and unexpected products by category
             When I filter products by "<category>" category
             Then the catalog should remain on the main page
              And the product "<expected_product>" should be displayed in the catalog
              And the product "<unexpected_product>" should not be displayed in the catalog

        Examples:
                  | category | expected_product | unexpected_product |
                  | Phones   | Nokia lumia 1520 | Sony vaio i5       |
                  | Laptops  | Sony vaio i5     | Nexus 6            |
                  | Monitors | Apple monitor 24 | Samsung galaxy s6  |