Feature: Demoblaze product pagination
  As a user
  I want to navigate through product pages using Next and Previous buttons
  So that I can see all available products

Background:
  Given I browse to Demoblaze page

@smoke_test_pagination_previous
Scenario: Click on Previous button from page 1
  Then the page should display the following products:
    | Samsung galaxy s6   |
    | Nokia lumia 1520    |
    | Nexus 6             |
    | Samsung galaxy s7   |
    | Iphone 6 32gb       |
    | Sony xperia z5      |
    | HTC One M9          |
    | Sony vaio i5        |
    | Sony vaio i7        |
  When I click the "Previous" pagination button
  Then the page should display the following products:
    | Samsung galaxy s7   |
    | Nexus 6             |
    | Nokia lumia 1520    |
    | Iphone 6 32gb       |
    | Sony xperia z5      |
    | HTC One M9          |
    | Sony vaio i5        |
    | Sony vaio i7        |
    | Apple monitor 24    |

@smoke_test_pagination_next
Scenario: Click on Next button from page 1
  Then the page should display the following products:
    | Samsung galaxy s6   |
    | Nokia lumia 1520    |
    | Nexus 6             |
    | Samsung galaxy s7   |
    | Iphone 6 32gb       |
    | Sony xperia z5      |
    | HTC One M9          |
    | Sony vaio i5        |
    | Sony vaio i7        |
  When I click the "Next" pagination button
  Then the page should display the following products:
    | Apple monitor 24    |
    | MacBook air         |
    | Dell i7 8gb         |
    | 2017 Dell 15.6 Inch |
    | ASUS Full HD        |
    | MacBook Pro         |