Given('I browse to Demoblaze page') do
  visit '/'
end

When('I click on {string} option') do |option_text|
  click_link(option_text)
end

When('I enter the registered username in the sign up username field') do
  find(:css, '#sign-username', wait: 10).set(ENV['DEMOBLAZE_USER'])
end

When('I enter the registered password in the sign up password field') do
  find(:css, '#sign-password', wait: 10).set(ENV['DEMOBLAZE_PASSWORD'])
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
