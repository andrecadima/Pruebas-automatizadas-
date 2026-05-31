When('I open the product detail page for {string}') do |product_name|
  puts "***OPENING PRODUCT DETAIL FOR: #{product_name}"

  find(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10).click

  expect(page).to have_selector('.name', wait: 10)

  puts "***PRODUCT DETAIL PAGE OPENED FOR: #{product_name}"
end

Then('the product detail name should be {string}') do |expected_product_name|
  actual_product_name = find(:css, '.name', wait: 10).text

  puts "***PRODUCT NAME FOUND: #{actual_product_name}"

  if actual_product_name != expected_product_name
    raise "Product name is wrong. Expected: #{expected_product_name} Actual: #{actual_product_name}"
  end
end

Then('the product detail price should contain {string}') do |expected_price|
  actual_price = find(:css, '.price-container', wait: 10).text

  puts "***PRODUCT PRICE FOUND: #{actual_price}"

  unless actual_price.include?(expected_price)
    raise "Product price is wrong. Expected to contain: #{expected_price} Actual: #{actual_price}"
  end
end

Then('the Add to cart button should be displayed') do
  expect(page).to have_selector(:xpath, "//a[normalize-space()='Add to cart']", wait: 10)

  puts "***ADD TO CART BUTTON IS DISPLAYED"
end