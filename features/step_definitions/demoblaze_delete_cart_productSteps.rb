When('I add the product {string} to the cart for deletion test') do |product_name|
  puts "***ADDING PRODUCT FOR DELETE TEST: #{product_name}"

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

  puts "***PRODUCT ADDED FOR DELETE TEST: #{product_name}"
end

When('I open the cart page for deletion test') do
  click_link('Cart')

  sleep 3

  expect(page).to have_current_path('/cart.html', wait: 10)
  expect(page).to have_selector('#tbodyid', wait: 10)

  puts "***CART PAGE OPENED FOR DELETE TEST"
end

Then('the cart should show the product {string} for deletion test') do |product_name|
  cart_text = find(:css, '#tbodyid', wait: 10).text

  puts "***CART CONTENT BEFORE DELETE:"
  puts cart_text

  unless cart_text.include?(product_name)
    raise "Product was not found in cart before delete. Expected: #{product_name}. Cart content: #{cart_text}"
  end

  puts "***PRODUCT FOUND BEFORE DELETE: #{product_name}"
end

When('I delete the product {string} from the cart for deletion test') do |product_name|
  puts "***DELETING PRODUCT FROM CART: #{product_name}"

  delete_xpath = "//tr[td[normalize-space()='#{product_name}']]//a[normalize-space()='Delete']"

  expect(page).to have_selector(:xpath, delete_xpath, wait: 10)

  find(:xpath, delete_xpath, wait: 10).click

  sleep 4

  puts "***DELETE CLICKED FOR PRODUCT: #{product_name}"
end

Then('the cart should not show the product {string} for deletion test') do |product_name|
  expect(page).to have_no_selector(:xpath, "//tbody[@id='tbodyid']//td[normalize-space()='#{product_name}']", wait: 10)

  cart_text = find(:css, '#tbodyid', wait: 10).text

  puts "***CART CONTENT AFTER DELETE:"
  puts cart_text

  if cart_text.include?(product_name)
    raise "Product is still visible after delete. Product: #{product_name}. Cart content: #{cart_text}"
  end

  puts "***PRODUCT REMOVED SUCCESSFULLY: #{product_name}"
end