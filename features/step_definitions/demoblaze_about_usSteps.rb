Then('the about us modal should be displayed') do
  modal = find(:css, '#videoModal', wait: 10)
  expect(modal).to be_visible

  puts "***ABOUT US MODAL DISPLAYED"
end

Then('the about us modal should contain a video preview') do
  within('#videoModal') do
    expect(page).to have_selector('video, iframe, .video-js', wait: 10)

    puts "***VIDEO PREVIEW FOUND"
  end
end

Then('the about us modal should contain a message') do
  within('#videoModal') do
    body = find('.modal-body', wait: 10)

    message = body.text.strip

    expect(message.length).to be > 0

    puts "***ABOUT US MESSAGE FOUND"
  end
end

Then('the about us video source should be loaded') do
  within('#videoModal') do

    video = find('video', wait: 10)

    src = video[:src]

    puts "***VIDEO SRC: #{src}"

    expect(src).not_to be_nil
    expect(src).not_to eq('')
  end
end

Then('the about us video player should have playback controls') do
  within('#videoModal') do

    expect(page).to have_selector('#example-video', wait: 10)

    expect(page).to have_selector('.vjs-play-control', visible: :all, wait: 10)

    expect(page).to have_selector('.vjs-progress-control', visible: :all, wait: 10)

    puts "***VIDEO PLAYBACK CONTROLS FOUND"
  end
end

When('I click the "Close" button in the about us modal') do
  modal = find(:css, '#videoModal', visible: true, wait: 10)

  expect(modal).to be_visible

  sleep 2

  within('#videoModal') do
    close_button =
      if has_selector?("button", text: 'Close', wait: 5)
        find('button', text: 'Close', wait: 10)
      else
        find('.modal-footer button.btn-secondary', wait: 10)
      end

    close_button.click
  end

  sleep 2

  puts "***CLICKED: Close button in About Us modal"
end

When('I click the "X" button in the about us modal') do
  modal = find(:css, '#videoModal', visible: true, wait: 10)

  expect(modal).to be_visible

  sleep 2

  within('#videoModal') do
    find('.modal-header button.close, button[aria-label="Close"]', wait: 10).click
  end

  sleep 2

  puts "***CLICKED: X button in About Us modal"
end

Then('the about us modal should be closed') do

  expect(page).to have_no_selector('#videoModal.show', wait: 10)

  puts "***ABOUT US MODAL CLOSED"
end

When('I play the about us video') do
  within('#videoModal') do

    if has_selector?('.vjs-big-play-button', visible: :all, wait: 5)
      find('.vjs-big-play-button', visible: :all).click
    else
      page.execute_script(
        "document.querySelector('#videoModal video').play();"
      )
    end
  end

  sleep 3

  puts "***VIDEO PLAY STARTED"
end

Then('the about us video should be playing') do

  initial_time = page.evaluate_script(
    "document.querySelector('#videoModal video').currentTime"
  )

  playing = false

  10.times do
    sleep 1

    current_time = page.evaluate_script(
      "document.querySelector('#videoModal video').currentTime"
    )

    if current_time > initial_time
      puts "***VIDEO ADVANCED FROM #{initial_time} TO #{current_time}"
      playing = true
      break
    end
  end

  expect(playing).to eq(true)

  puts "***VIDEO IS PLAYING"
end