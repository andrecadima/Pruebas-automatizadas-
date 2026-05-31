Feature: Demoblaze complete purchase flow

        Background:
            Given I browse to Demoblaze page
              And I am logged in with a registered user

        @smoke_test_purchase_complete
        Scenario: Complete a successful purchase order
             When I click on the "Samsung galaxy s6" product
             Then the product detail page should be displayed for "Samsung galaxy s6"
             When I click on the Add to cart button
             Then the alert message should be "Product added."
             When I click on "Cart" option
             Then I should see the product "Samsung galaxy s6" in the cart
             When I click on the "Place Order" button
             Then the place order modal should be displayed
             When I fill in the purchase form with:
                  | Name        | QA Tester Ariel     |
                  | Country     | Bolivia             |
                  | City        | Cochabamba          |
                  | Credit Card | 1234 5678 9012 3456 |
                  | Month       | 12                  |
                  | Year        | 2026                |
              And I click on the "Purchase" button
             Then the success message should be "Thank you for your purchase!"
              And I should remain on the cart page after purchase