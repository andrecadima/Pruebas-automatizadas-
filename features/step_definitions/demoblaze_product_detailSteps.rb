When('I open the product detail page for {string}') do |product_name|


  find(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10).click

  expect(page).to have_selector('.name', wait: 10)

  
end

Then('the product detail name should be {string}') do |expected_product_name|
  actual_product_name = find(:css, '.name', wait: 10).text

  

  if actual_product_name != expected_product_name
    raise "Product name is wrong. Expected: #{expected_product_name} Actual: #{actual_product_name}"
  end
end

Then('the product detail price should contain {string}') do |expected_price|
  actual_price = find(:css, '.price-container', wait: 10).text

  

  unless actual_price.include?(expected_price)
    raise "Product price is wrong. Expected to contain: #{expected_price} Actual: #{actual_price}"
  end
end

Then('the Add to cart button should be displayed') do
  expect(page).to have_selector(:xpath, "//a[normalize-space()='Add to cart']", wait: 10)
 
end

# ============================================
# NUEVOS STEPS PARA LENGUAJE NATURAL
# ============================================

Then('I see the product name {string}') do |expected_name|
  actual_name = find(:css, '.name', wait: 10).text
  expect(actual_name).to eq(expected_name)
  
end

Then('I see the product price {string}') do |expected_price|
  actual_price = find(:css, '.price-container', wait: 10).text
  expect(actual_price).to include(expected_price)
  
end

Then('I see the {string} button') do |button_text|
  expect(page).to have_link(button_text, wait: 10)
 
end