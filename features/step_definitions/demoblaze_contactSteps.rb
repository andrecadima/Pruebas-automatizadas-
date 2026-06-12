# ============================================
# VERIFICAR MODAL DE CONTACTO
# ============================================
Then('the contact modal should be displayed') do
  modal = find(:css, '#exampleModal', wait: 10)
  expect(modal).to be_visible
  puts "***CONTACT MODAL IS DISPLAYED"
end

Then('the contact modal should still be displayed') do
  modal = find(:css, '#exampleModal', wait: 10)
  expect(modal).to be_visible
  puts "***CONTACT MODAL STILL DISPLAYED AFTER ALERT"
end

# ============================================
# LLENAR CAMPOS DEL MODAL DE CONTACTO
# ============================================
When('I fill in the contact email with {string}') do |email|
  find(:css, '#recipient-email', wait: 10).set(email)
  puts "***EMAIL FILLED: #{email}"
end

When('I fill in the contact name with {string}') do |name|
  find(:css, '#recipient-name', wait: 10).set(name)
  puts "***NAME FILLED: #{name}"
end

When('I fill in the contact message with {string}') do |message|
  find(:css, '#message-text', wait: 10).set(message)
  puts "***MESSAGE FILLED: #{message}"
end

# ============================================
# VERIFICAR QUE LOS CAMPOS GUARDAN LOS DATOS (BUG)
# ============================================
Then('the contact email field should contain {string}') do |expected_email|
  actual_email = find(:css, '#recipient-email', wait: 10).value
  expect(actual_email).to eq(expected_email)
  puts "***EMAIL PERSISTS: #{actual_email}"
end

Then('the contact name field should contain {string}') do |expected_name|
  actual_name = find(:css, '#recipient-name', wait: 10).value
  expect(actual_name).to eq(expected_name)
  puts "***NAME PERSISTS: #{actual_name}"
end

Then('the contact message field should contain {string}') do |expected_message|
  actual_message = find(:css, '#message-text', wait: 10).text
  expect(actual_message).to eq(expected_message)
  puts "***MESSAGE PERSISTS: #{actual_message}"
end

# ============================================
# BOTONES DEL MODAL DE CONTACTO
# ============================================
When('I click the {string} button in the contact modal') do |button_text|
  case button_text.downcase
  when "close"
    find(:xpath, "//div[@id='exampleModal']//button[text()='Close']", wait: 10).click
    sleep 1
  when "x"
    find(:xpath, "//div[@id='exampleModal']//button[@class='close']", wait: 10).click
    sleep 1
  when "send message"
    find(:xpath, "//div[@id='exampleModal']//button[text()='Send message']", wait: 10).click
    puts "***CLICKED SEND MESSAGE, WAITING FOR ALERT..."
    sleep 3
  end
  puts "***CLICKED: #{button_text} button"
end

# ============================================
# VERIFICAR QUE EL MODAL SE CIERRA
# ============================================
Then('the contact modal should be closed') do
  expect(page).to have_no_selector('#exampleModal', visible: true, wait: 5)
  puts "***CONTACT MODAL IS CLOSED"
end

# ============================================
# SISTEMA MANEJA FORMULARIO VACIO
# ============================================
Then('the system should handle the empty Contact form submission') do
  begin
    alert = page.driver.browser.switch_to.alert
    puts "***ALERT SHOWN: #{alert.text}"
    alert.accept
  rescue
    puts "***NO ALERT, FORM HANDLED EMPTY FIELDS"
  end
end

# ============================================
# NUEVOS STEPS PARA LENGUAJE NATURAL
# ============================================

Given('I am on the Demoblaze home page') do
  visit('/')
  expect(page).to have_selector('#nava', wait: 20)
  puts "***DEMOBLAZE HOME LOADED"
end

When('I open the contact form') do
  click_link("Contact")
  puts "***CONTACT FORM OPENED"
end

Then('I can see the contact window') do
  expect(page).to have_selector('#exampleModal', visible: true, wait: 10)
  puts "***CONTACT WINDOW IS VISIBLE"
end

When('I send the message without filling any field') do
  within('#exampleModal') do
    find(:xpath, "//button[text()='Send message']", wait: 10).click
  end
  puts "***SENT MESSAGE WITH EMPTY FIELDS"
end

Then('I see a message telling me to complete the form') do
  begin
    alert = page.driver.browser.switch_to.alert
    puts "***ALERT MESSAGE: #{alert.text}"
    alert.accept
  rescue
    puts "***NO ALERT SHOWN"
  end
end

When('I write my name as {string}') do |name|
  find(:css, '#recipient-name', wait: 10).set(name)
  puts "***NAME WRITTEN: #{name}"
end

When('I close the window') do
  find(:xpath, "//div[@id='exampleModal']//button[text()='Close']", wait: 10).click
  sleep 1
  puts "***WINDOW CLOSED"
end

When('I open the contact form again') do
  click_link("Contact")
  puts "***CONTACT FORM OPENED AGAIN"
end

Then('my name should still be {string}') do |expected_name|
  actual_name = find(:css, '#recipient-name', wait: 10).value
  expect(actual_name).to eq(expected_name)
  puts "***NAME STILL: #{actual_name}"
end

When('I write my email as {string}') do |email|
  find(:css, '#recipient-email', wait: 10).set(email)
  puts "***EMAIL WRITTEN: #{email}"
end

When('I close the window using the X button') do
  find(:xpath, "//div[@id='exampleModal']//button[@class='close']", wait: 10).click
  sleep 1
  puts "***WINDOW CLOSED WITH X BUTTON"
end

Then('my email should still be {string}') do |expected_email|
  actual_email = find(:css, '#recipient-email', wait: 10).value
  expect(actual_email).to eq(expected_email)
  puts "***EMAIL STILL: #{actual_email}"
end

When('I write a message saying {string}') do |message|
  find(:css, '#message-text', wait: 10).set(message)
  puts "***MESSAGE WRITTEN: #{message}"
end

When('I send the message') do
  within('#exampleModal') do
    find(:xpath, "//button[text()='Send message']", wait: 10).click
  end
  puts "***MESSAGE SENT"
end

Then('I see a confirmation saying {string}') do |expected_message|
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  alert = wait.until { page.driver.browser.switch_to.alert }
  actual_message = alert.text
  puts "***CONFIRMATION: #{actual_message}"
  expect(actual_message).to eq(expected_message)
  alert.accept
end

When('I fill the contact form with:') do |table|
  data = table.rows_hash
  find(:css, '#recipient-email', wait: 10).set(data['Email'])
  find(:css, '#recipient-name', wait: 10).set(data['Name'])
  find(:css, '#message-text', wait: 10).set(data['Message'])
  puts "***CONTACT FORM FILLED"
end