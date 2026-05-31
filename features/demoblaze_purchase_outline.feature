Feature: Demoblaze purchase with different customer data
              As a logged user
              I want to complete purchases with different customer data
  So that I can validate the purchase flow using multiple datasets

        Background:
            Given I browse to Demoblaze page
              And I am logged in with a registered user
              And I start with an empty Demoblaze cart

        @purchase_with_multiple_customer_data
        Scenario Outline: Complete purchase using different customer information
             When I add "<product_name>" to the cart for purchase outline
              And I open the cart page for purchase outline
             Then the cart should display "<product_name>" for purchase outline
             When I click the Place Order button for purchase outline
             Then the purchase modal should be visible for purchase outline
             When I complete the purchase outline form with "<name>", "<country>", "<city>", "<card>", "<month>" and "<year>"
              And I confirm the purchase for purchase outline
             Then the purchase outline success message should be "Thank you for your purchase!"

        Examples:
                  | product_name      | name            | country | city       | card             | month | year |
                  | Samsung galaxy s6 | QA Tester Ariel | Bolivia | Cochabamba | 1234567890123456 | 12    | 2026 |
                  | Nexus 6           | Demo User Test  | Bolivia | La Paz     | 9999888877776666 | 01    | 2027 |