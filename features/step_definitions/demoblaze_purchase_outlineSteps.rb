When('I add {string} to the cart for purchase outline') do |product_name|
  puts "***ADDING PRODUCT FOR PURCHASE OUTLINE: #{product_name}"

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

  puts "***PRODUCT ADDED FOR PURCHASE OUTLINE: #{product_name}"
end

When('I open the cart page for purchase outline') do
  click_link('Cart')

  sleep 3

  expect(page).to have_current_path('/cart.html', wait: 10)
  expect(page).to have_selector('#tbodyid', wait: 10)

  puts "***CART PAGE OPENED FOR PURCHASE OUTLINE"
end

Then('the cart should display {string} for purchase outline') do |product_name|
  cart_text = find(:css, '#tbodyid', wait: 10).text

  puts "***CART CONTENT FOR PURCHASE OUTLINE:"
  puts cart_text

  unless cart_text.include?(product_name)
    raise "Product not found in cart. Expected: #{product_name}. Cart content: #{cart_text}"
  end

  puts "***PRODUCT FOUND IN CART FOR PURCHASE OUTLINE: #{product_name}"
end

When('I click the Place Order button for purchase outline') do
  find(:xpath, "//button[normalize-space()='Place Order']", wait: 10).click

  sleep 2

  puts "***CLICKED PLACE ORDER BUTTON FOR PURCHASE OUTLINE"
end

Then('the purchase modal should be visible for purchase outline') do
  modal = find(:css, '#orderModal', visible: true, wait: 10)

  expect(modal).to be_visible

  puts "***PURCHASE MODAL IS VISIBLE FOR PURCHASE OUTLINE"
end

When('I complete the purchase outline form with {string}, {string}, {string}, {string}, {string} and {string}') do |name, country, city, card, month, year|
  find(:css, '#name', wait: 10).set(name)
  find(:css, '#country', wait: 10).set(country)
  find(:css, '#city', wait: 10).set(city)
  find(:css, '#card', wait: 10).set(card)
  find(:css, '#month', wait: 10).set(month)
  find(:css, '#year', wait: 10).set(year)

  puts "***PURCHASE FORM COMPLETED WITH:"
  puts "***NAME: #{name}"
  puts "***COUNTRY: #{country}"
  puts "***CITY: #{city}"
  puts "***CARD: #{card}"
  puts "***MONTH: #{month}"
  puts "***YEAR: #{year}"
end

When('I confirm the purchase for purchase outline') do
  find(:xpath, "//button[normalize-space()='Purchase']", wait: 10).click

  sleep 2

  puts "***PURCHASE CONFIRMED FOR PURCHASE OUTLINE"
end

Then('the purchase outline success message should be {string}') do |expected_message|
  sweet_alert = find(:css, '.sweet-alert', visible: true, wait: 10)

  expect(sweet_alert).to be_visible

  actual_message = sweet_alert.find('h2', wait: 10).text

  puts "***PURCHASE SUCCESS MESSAGE: #{actual_message}"

  if actual_message != expected_message
    raise "Purchase success message is wrong. Expected: #{expected_message} Actual: #{actual_message}"
  end

  sweet_alert.find('button', text: 'OK', wait: 10).click

  sleep 2

  puts "***PURCHASE SUCCESS MODAL CLOSED"
end