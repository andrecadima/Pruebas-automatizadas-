When('I open the Contact modal for empty fields test') do
  click_link('Contact')

  sleep 2

  puts "***CLICKED CONTACT OPTION FOR EMPTY FIELDS TEST"
end

Then('the Contact modal should be displayed for empty fields test') do
  modal = find(:css, '#exampleModal', visible: true, wait: 10)

  expect(modal).to be_visible

  puts "***CONTACT MODAL IS DISPLAYED FOR EMPTY FIELDS TEST"
end

When('I leave the Contact form fields empty') do
  within('#exampleModal') do
    email = find(:css, '#recipient-email', wait: 10)
    name = find(:css, '#recipient-name', wait: 10)
    message = find(:css, '#message-text', wait: 10)

    email.set('')
    name.set('')
    message.set('')
  end

  puts "***CONTACT FORM FIELDS LEFT EMPTY"
end

When('I click the Send message button for empty fields contact test') do
  within('#exampleModal') do
    find(:xpath, ".//button[normalize-space()='Send message']", wait: 10).click
  end

  sleep 2

  puts "***CLICKED SEND MESSAGE BUTTON WITH EMPTY CONTACT FORM"
end

Then('the system should handle the empty Contact form submission') do
  wait = Selenium::WebDriver::Wait.new(timeout: 10)

  alert = wait.until do
    begin
      page.driver.browser.switch_to.alert
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      nil
    end
  end

  actual_message = alert.text.strip

  puts "***CONTACT EMPTY FORM ALERT MESSAGE: #{actual_message}"

  if actual_message == 'Thanks for the message!!'
    puts "***OBSERVATION: Demoblaze allows sending the Contact form with empty fields."
    puts "***POTENTIAL BUG: Empty Email, Name, and Message fields are accepted."
  else
    puts "***SYSTEM DISPLAYED VALIDATION MESSAGE: #{actual_message}"
  end

  alert.accept

  sleep 2

  puts "***EMPTY CONTACT FORM BEHAVIOR VALIDATED"
end