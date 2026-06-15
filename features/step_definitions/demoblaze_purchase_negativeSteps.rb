

When('I add {string} to the cart for negative purchase test') do |product_name|


  expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10)

  find(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10).click

  expect(page).to have_selector(:css, '.name', wait: 10)

  actual_product_name = find(:css, '.name', wait: 10).text

  if actual_product_name != product_name
    raise "Wrong product detail page. Expected: #{product_name} Actual: #{actual_product_name}"
  end

  find(:xpath, "//a[normalize-space()='Add to cart']", wait: 10).click

  wait = Selenium::WebDriver::Wait.new(timeout: 10)

  alert = wait.until do
    begin
      page.driver.browser.switch_to.alert
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      nil
    end
  end

  actual_alert = alert.text.strip
  puts "***ALERT MESSAGE: #{actual_alert}"

  unless actual_alert == 'Product added' || actual_alert == 'Product added.'
    raise "Wrong alert message. Expected: Product added Actual: #{actual_alert}"
  end

  alert.accept

  sleep 3


end

When('I open the cart page for negative purchase test') do
  click_link('Cart')

  sleep 3

  expect(page).to have_current_path('/cart.html', wait: 10)
  expect(page).to have_selector('#tbodyid', wait: 10)


end

Then('the cart should display {string} for negative purchase test') do |product_name|
  cart_text = find(:css, '#tbodyid', wait: 10).text


  

  unless cart_text.include?(product_name)
    raise "Product not found in cart. Expected: #{product_name}. Cart content: #{cart_text}"
  end


end

When('I click the Place Order button for negative purchase test') do
  find(:xpath, "//button[normalize-space()='Place Order']", wait: 10).click

  sleep 2


end

Then('the purchase modal should be visible for negative purchase test') do
  modal = find(:css, '#orderModal', visible: true, wait: 10)

  expect(modal).to be_visible


end

When('I complete the negative purchase form leaving {string} empty') do |missing_field|
  test_data = {
    'Name' => 'QA Negative Tester',
    'Country' => 'Bolivia',
    'City' => 'Cochabamba',
    'Credit Card' => '1234567890123456',
    'Month' => '12',
    'Year' => '2026'
  }

  test_data[missing_field] = ''

  find(:css, '#name', wait: 10).set(test_data['Name'])
  find(:css, '#country', wait: 10).set(test_data['Country'])
  find(:css, '#city', wait: 10).set(test_data['City'])
  find(:css, '#card', wait: 10).set(test_data['Credit Card'])
  find(:css, '#month', wait: 10).set(test_data['Month'])
  find(:css, '#year', wait: 10).set(test_data['Year'])

  @missing_field = missing_field


  
end

When('I confirm the purchase for negative purchase test') do
  find(:xpath, "//button[normalize-space()='Purchase']", wait: 10).click

  sleep 2

  
end

Then('the system should handle the missing {string} field in the purchase form') do |missing_field|
  sleep 2

  wait = Selenium::WebDriver::Wait.new(timeout: 10)

  alert = wait.until do
    begin
      page.driver.browser.switch_to.alert
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      nil
    end
  end

  actual_alert = alert.text.strip
  expected_alert = 'Please fill out Name and Creditcard.'

  puts "***MISSING FIELD: #{missing_field}"
  puts "***VALIDATION ALERT: #{actual_alert}"

  if actual_alert != expected_alert
    raise "Wrong validation alert. Expected: #{expected_alert} Actual: #{actual_alert}"
  end

  alert.accept

  sleep 2

  expect(page).to have_selector('#orderModal', visible: true, wait: 10)

  
end