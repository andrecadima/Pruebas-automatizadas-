When('I open the Contact modal for successful message test') do
  click_link('Contact')

  sleep 2

  puts "***CLICKED CONTACT OPTION"
end

Then('the Contact modal should be displayed for successful message test') do
  modal = find(:css, '#exampleModal', visible: true, wait: 10)

  expect(modal).to be_visible

  puts "***CONTACT MODAL IS DISPLAYED"
end

When('I fill the Contact form with:') do |table|
  data = table.rows_hash

  within('#exampleModal') do
    find(:css, '#recipient-email', wait: 10).set(data['Email'])
    find(:css, '#recipient-name', wait: 10).set(data['Name'])
    find(:css, '#message-text', wait: 10).set(data['Message'])
  end

  puts "***CONTACT FORM COMPLETED"
  puts "***EMAIL: #{data['Email']}"
  puts "***NAME: #{data['Name']}"
  puts "***MESSAGE: #{data['Message']}"
end

When('I click the Send message button for successful contact test') do
  within('#exampleModal') do
    find(:xpath, ".//button[normalize-space()='Send message']", wait: 10).click
  end

  sleep 2

  puts "***CLICKED SEND MESSAGE BUTTON"
end

Then('the Contact alert message should be {string}') do |expected_message|
  wait = Selenium::WebDriver::Wait.new(timeout: 10)

  alert = wait.until do
    begin
      page.driver.browser.switch_to.alert
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      nil
    end
  end

  actual_message = alert.text.strip

  puts "***CONTACT ALERT MESSAGE: #{actual_message}"

  if actual_message != expected_message
    raise "Contact alert message is wrong. Expected: #{expected_message} Actual: #{actual_message}"
  end

  alert.accept

  sleep 2

  puts "***CONTACT ALERT ACCEPTED"
end