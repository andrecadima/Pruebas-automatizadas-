Feature: Demoblaze cart total validation
              As a demo user
              I want to add multiple products to the cart
  So that I can validate that the cart total is calculated correctly

        Background:
            Given I browse to Demoblaze page
              And I start with an empty Demoblaze cart

        @cart_total_validation
        Scenario: Validate cart total with multiple products using data table
             When I add products with prices to the Demoblaze cart:
                  | Product           | Price |
                  | Samsung galaxy s6 | 360   |
                  | Nexus 6           | 650   |
              And I open the Demoblaze cart page
             Then the Demoblaze cart total should be equal to the expected total