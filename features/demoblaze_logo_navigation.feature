Feature: Demoblaze logo navigation
  As a user
  I want to click on the logo from any page
  So that I can return to the home page easily

Background:
  Given I browse to Demoblaze page

@logo_navigation_from_cart
Scenario: Click on logo returns to home page from Cart
  When I add the product "Samsung galaxy s6" to the cart
  And I click on "Cart" option
  Then I should be on the cart page
  When I click on the logo
  Then I should be redirected to the home page
  And the cart should still contain the added items

@logo_navigation_from_product_detail
Scenario: Click on logo returns to home page from Product detail
  When I click on the "Samsung galaxy s6" product
  Then I should be on the product detail page for "Samsung galaxy s6"
  When I click on the logo
  Then I should be redirected to the home page
  And the product detail page should be closed