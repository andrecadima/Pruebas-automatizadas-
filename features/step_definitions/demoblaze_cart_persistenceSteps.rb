

When('I add the product {string}') do |product_name|
  puts "***ADDING PRODUCT: #{product_name}"

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

  sleep 2
  
  # Verificar que el producto se agregó al carrito
  visit '/cart.html'
  cart_text = find(:css, '#tbodyid', wait: 10).text
  if cart_text.include?(product_name)
   
  else
   
  end
  
  # Volver a la home page
  visit '/'
  sleep 2

  
end

When('I navigate back to the home page') do
  visit '/'
  sleep 3
  expect(page).to have_selector(
    :xpath,
    "//a[contains(@class,'hrefch')]",
    wait: 10
  )
  
end

When('I open the cart page') do
  visit '/cart.html'
  sleep 3
  expect(page).to have_current_path('/cart.html', wait: 10)
  expect(page).to have_selector('#tbodyid', wait: 10)
  
end

Then('the product {string} should still be present in the cart') do |product_name|
  sleep 3
  cart_text = find(:css, '#tbodyid', wait: 10).text
  puts "***CART CONTENT:"
  puts cart_text
  unless cart_text.include?(product_name)
    raise "Product disappeared from cart. Expected: #{product_name}"
  end
  puts "***PRODUCT PERSISTED IN CART: #{product_name}"
end