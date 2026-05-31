Feature: Demoblaze About Us video playback

              As a user
              I want to play the About Us video
    So that I can verify the multimedia content is working correctly

        Background:
            Given I browse to Demoblaze page

        @about_us_video_playback
        Scenario: Play About Us video successfully
             When I click on "About us" option
             Then the about us modal should be displayed
              And the about us video source should be loaded

             When I play the about us video

             Then the about us video should be playing