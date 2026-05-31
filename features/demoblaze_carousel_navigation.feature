Feature: Demoblaze Carousel Navigation

              As a user
              I want to navigate through the homepage carousel
    So that I can view the promotional banners

        Background:
            Given I browse to Demoblaze page

        @carousel_visible
        Scenario: Carousel is displayed
             Then the carousel should be visible

        @carousel_next
        Scenario: Navigate to next carousel image
             Then the carousel should be visible
             When I click the next carousel button
             Then the carousel image should change

        @carousel_previous
        Scenario: Navigate to previous carousel image
             Then the carousel should be visible
             When I click the previous carousel button
             Then the carousel image should change

        @carousel_navigation
        Scenario: Navigate carousel forward and backward
             Then the carousel should be visible

             When I click the next carousel button
             Then the carousel image should change

             When I click the previous carousel button
             Then the carousel image should change