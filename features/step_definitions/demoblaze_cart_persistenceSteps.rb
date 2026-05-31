When('I add the product {string} for persistence validation') do |product_name|
  puts "***ADDING PRODUCT FOR PERSISTENCE TEST: #{product_name}"

  find(
    :xpath,
    "//a[contains(@class,'hrefch') and normalize-space()='#{product_name}']",
    wait: 10
  ).click

  expect(page).to have_selector(:css, '.name', wait: 2)

  actual_product = find(:css, '.name').text

  if actual_product != product_name
    raise "Wrong product page. Expected: #{product_name} Actual: #{actual_product}"
  end

  find(
    :xpath,
    "//a[normalize-space()='Add to cart']",
    wait: 2
  ).click

  wait = Selenium::WebDriver::Wait.new(timeout: 2)

  alert = wait.until do
    begin
      page.driver.browser.switch_to.alert
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      nil
    end
  end

  puts "***ALERT: #{alert.text}"

  alert.accept

  sleep 3

  puts "***PRODUCT ADDED SUCCESSFULLY"
end

When('I navigate back to the home page for persistence validation') do
  visit 'https://demoblaze.com'

  sleep 3

  expect(page).to have_selector(
    :xpath,
    "//a[contains(@class,'hrefch')]",
    wait: 2
  )

  puts "***RETURNED TO HOME PAGE"
end

When('I open the cart page for persistence validation') do
  find(:link, 'Cart', wait: 10).click

  sleep 3

  expect(page).to have_current_path('/cart.html', wait: 2)

  expect(page).to have_selector('#tbodyid', wait: 2)

  puts "***CART PAGE OPENED"
end

Then('the product {string} should still be present in the cart') do |product_name|
  sleep 3

  cart_text = find(:css, '#tbodyid', wait: 2).text

  puts "***CART CONTENT:"
  puts cart_text

  unless cart_text.include?(product_name)
    raise "Product disappeared from cart. Expected: #{product_name}"
  end

  puts "***PRODUCT PERSISTED IN CART: #{product_name}"
end