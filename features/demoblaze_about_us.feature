Feature: Demoblaze About Us section
  As a user
  I want to see the company information and watch the promotional video
  So that I can learn more about Demoblaze

  Background:
    Given I browse to Demoblaze page

  @smoke_test_about_us_modal
  Scenario: Open and see the About Us information
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us modal should contain a video preview
    And the about us modal should contain a "Play Video" button

  @about_us_video_source
  Scenario: Video loads correctly
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us video source should be loaded

  @about_us_video_playback
  Scenario: Video has play controls
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us video player should have playback controls

  @about_us_close_button
  Scenario: Close the information panel using the Close button
    When I click on "About us" option
    Then the about us modal should be displayed
    When I click the "Close" button in the about us modal
    Then the about us modal should be closed

  @about_us_x_button
  Scenario: Close the information panel using the X button
    When I click on "About us" option
    Then the about us modal should be displayed
    When I click the "X" button in the about us modal
    Then the about us modal should be closed

  @about_us_video_play_success
  Scenario: Play the video successfully
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us video source should be loaded
    When I play the about us video
    Then the about us video should be playing