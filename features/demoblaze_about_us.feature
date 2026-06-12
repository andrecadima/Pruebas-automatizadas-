Feature: Demoblaze About Us modal
  As a user
  I want to view the About Us information and interact with the video
  So that I can learn more about Demoblaze and verify multimedia content

  Background:
    Given I browse to Demoblaze page

  @smoke_test_about_us_modal
  Scenario: Open and view About Us modal
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us modal should contain a video preview
    And the about us modal should contain a message

  @about_us_video_source
  Scenario: Video source is loaded
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us video source should be loaded

  @about_us_video_playback
  Scenario: Video playback controls are available
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us video player should have playback controls

  @about_us_close_button
  Scenario: Close About Us modal with close button
    When I click on "About us" option
    Then the about us modal should be displayed
    When I click the "Close" button in the about us modal
    Then the about us modal should be closed

  @about_us_x_button
  Scenario: Close About Us modal with X button
    When I click on "About us" option
    Then the about us modal should be displayed
    When I click the "X" button in the about us modal
    Then the about us modal should be closed

  @about_us_video_play_success
  Scenario: Play About Us video successfully
    When I click on "About us" option
    Then the about us modal should be displayed
    And the about us video source should be loaded
    When I play the about us video
    Then the about us video should be playing