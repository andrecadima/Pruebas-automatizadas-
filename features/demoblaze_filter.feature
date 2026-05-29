Feature: Demoblaze product category filtering
  As a demo user
  I want to filter products by category
  So that I can validate that products are displayed correctly by category

Background:
  Given I browse to Demoblaze page

@demoblaze_phones_filter
Scenario Outline: Validate products after filtering by Phones category
  Then the product "Samsung galaxy s6" should be visible before filtering
  When I click on the "Phones" category
  Then the page should remain on Demoblaze home
  And the product "<product_name>" should be visible in the category list

Examples:
  | product_name     |
  | Nokia lumia 1520 |
  | Nexus 6          |

@demoblaze_laptops_filter
Scenario Outline: Validate products after filtering by Laptops category
  Then the product "Samsung galaxy s6" should be visible before filtering
  When I click on the "Laptops" category
  Then the page should remain on Demoblaze home
  And the product "<product_name>" should be visible in the category list

Examples:
  | product_name  |
  | Sony vaio i5  |
  | Sony vaio i7  |

@demoblaze_monitors_filter
Scenario Outline: Validate products after filtering by Monitors category
  Then the product "Samsung galaxy s6" should be visible before filtering
  When I click on the "Monitors" category
  Then the page should remain on Demoblaze home
  And the product "<product_name>" should be visible in the category list

Examples:
  | product_name      |
  | Apple monitor 24  |
  | ASUS Full HD      |