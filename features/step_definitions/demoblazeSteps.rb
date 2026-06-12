Given('I browse to Demoblaze page') do
  visit('https://www.demoblaze.com')

  expect(page).to have_selector(
    '#nava',
    wait: 20
  )

  puts "***DEMOBLAZE HOME LOADED"
end

When('I click on {string} option') do |option_text|
  click_link(option_text)
  puts "***CLICKED ON OPTION: #{option_text}"
  
  if option_text == "Cart"
    expect(page).to have_selector('h2', text: 'Products', wait: 10)
    puts "***CART PAGE LOADED"
  elsif option_text == "Contact"
    sleep 1
    expect(page).to have_selector('#exampleModal', wait: 10)
    puts "***CONTACT MODAL OPENED"
  end
end

When('I enter the registered username in the sign up username field') do
  find(:css, '#sign-username', wait: 10).set(ENV['DEMOBLAZE_USER'])
end

When('I enter the registered password in the sign up password field') do
  find(:css, '#sign-password', wait: 10).set(ENV['DEMOBLAZE_PASSWORD'])
end

# NUEVOS STEPS PARA REGISTRO CON DATOS ALEATORIOS
When('I enter a new random username in the sign up username field') do
  @random_user = "test_user_#{Time.now.to_i}"
  find(:css, '#sign-username', wait: 10).set(@random_user)
  puts "***RANDOM USERNAME: #{@random_user}"
end

When('I enter a new random password in the sign up password field') do
  @random_password = "pass_#{Time.now.to_i}"
  find(:css, '#sign-password', wait: 10).set(@random_password)
  puts "***RANDOM PASSWORD: #{@random_password}"
end

When('I enter the registered username in the log in username field') do
  find(:css, '#loginusername', wait: 10).set(ENV['DEMOBLAZE_USER'])
end

When('I enter the registered password in the log in password field') do
  find(:css, '#loginpassword', wait: 10).set(ENV['DEMOBLAZE_PASSWORD'])
end

When('I click on the {string} button in the pop up') do |button_text|
  find(:xpath, "//button[text()='#{button_text}']", wait: 10).click
end

When('I accept the alert') do
  page.driver.browser.switch_to.alert.accept
  puts "***ALERT ACCEPTED"
end

Then('the alert message should be {string}') do |expected_message|
  wait = Selenium::WebDriver::Wait.new(timeout: 10)

  alert = wait.until do
    begin
      page.driver.browser.switch_to.alert
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      nil
    end
  end

  actual_message = alert.text
  puts "***ALERT MESSAGE: #{actual_message}"

  if actual_message != expected_message
    raise "Alert message is wrong. Expected: #{expected_message} Actual: #{actual_message}"
  end

  alert.accept
end

Then('the welcome message should show the registered username') do
  expected_message = "Welcome #{ENV['DEMOBLAZE_USER']}"

  welcome_element = find(:css, '#nameofuser', wait: 10)
  actual_message = welcome_element.text

  puts "***WELCOME MESSAGE: #{actual_message}"

  if actual_message != expected_message
    raise "Welcome message is wrong. Expected: #{expected_message} Actual: #{actual_message}"
  end
end

Given('I am logged in with a registered user') do
  click_link("Log in")
  
  find(:css, '#loginusername', wait: 10).set(ENV['DEMOBLAZE_USER'])
  find(:css, '#loginpassword', wait: 10).set(ENV['DEMOBLAZE_PASSWORD'])
  
  find(:xpath, "//button[text()='Log in']", wait: 10).click
  
  expected_message = "Welcome #{ENV['DEMOBLAZE_USER']}"
  welcome_element = find(:css, '#nameofuser', wait: 10)
  actual_message = welcome_element.text
  
  if actual_message != expected_message
    raise "Login failed. Expected: #{expected_message} Actual: #{actual_message}"
  end
  
  puts "***USER LOGGED IN: #{ENV['DEMOBLAZE_USER']}"
end

# ============ ABOUT US STEPS ============

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

# ============ LOGOUT STEPS ============

Then('the welcome message should be visible before logout') do
  expect(page).to have_selector('#nameofuser', visible: true, wait: 10)
  puts "***WELCOME MESSAGE IS VISIBLE"
end

Then('the Log in option should be visible after logout') do
  expect(page).to have_link('Log in', visible: true, wait: 10)
  puts "***LOG IN OPTION IS VISIBLE"
end

Then('the Sign up option should be visible after logout') do
  expect(page).to have_link('Sign up', visible: true, wait: 10)
  puts "***SIGN UP OPTION IS VISIBLE"
end

Then('the welcome message should not be visible after logout') do
  expect(page).to have_no_selector('#nameofuser', wait: 10)
  puts "***WELCOME MESSAGE NOT VISIBLE"
end

