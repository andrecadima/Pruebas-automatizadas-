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
    puts "***ABOUT US MESSAGE (truncated): #{message[0..120]}"
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
  expect(page).to have_no_selector('.modal-backdrop', wait: 10)

  puts "***ABOUT US MODAL CLOSED"
end