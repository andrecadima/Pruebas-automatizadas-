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
    # Hacer clic en el botón Send message
    find(:xpath, "//div[@id='exampleModal']//button[text()='Send message']", wait: 10).click
    puts "***CLICKED SEND MESSAGE, WAITING FOR ALERT..."
    sleep 3  # Esperar a que la alerta aparezca
  end
  puts "***CLICKED: #{button_text} button"
end

# ============================================
# VERIFICAR QUE EL MODAL SE CIERRA (si aplica)
# ============================================
Then('the contact modal should be closed') do
  expect(page).to have_no_selector('#exampleModal', visible: true, wait: 5)
  puts "***CONTACT MODAL IS CLOSED"
end