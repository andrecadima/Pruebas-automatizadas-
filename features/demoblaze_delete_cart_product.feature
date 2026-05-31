Feature: Demoblaze delete product from cart
              As a demo user
              I want to delete a product from the cart
  So that I can validate that the cart removes products correctly

        Background:
            Given I browse to Demoblaze page
              And I start with an empty Demoblaze cart

        @delete_product_from_cart
        Scenario: Delete Samsung galaxy s6 from the cart
             When I add the product "Samsung galaxy s6" to the cart for deletion test
              And I open the cart page for deletion test
             Then the cart should show the product "Samsung galaxy s6" for deletion test
             When I delete the product "Samsung galaxy s6" from the cart for deletion test
             Then the cart should not show the product "Samsung galaxy s6" for deletion test