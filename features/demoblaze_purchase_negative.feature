Feature: Demoblaze negative purchase form validations
              As a logged user
              I want to test the purchase form with missing required fields
  So that I can identify validation issues in the Place Order form

        Background:
            Given I browse to Demoblaze page
              And I am logged in with a registered user
              And I start with an empty Demoblaze cart

        @negative_purchase_validation
        Scenario Outline: Attempt purchase with missing required field
             When I add "Samsung galaxy s6" to the cart for negative purchase test
              And I open the cart page for negative purchase test
             Then the cart should display "Samsung galaxy s6" for negative purchase test
             When I click the Place Order button for negative purchase test
             Then the purchase modal should be visible for negative purchase test
             When I complete the negative purchase form leaving "<missing_field>" empty
              And I confirm the purchase for negative purchase test
             Then the system should handle the missing "<missing_field>" field in the purchase form

        Examples:
                  | missing_field |
                  | Name          |
                  | Credit Card   |