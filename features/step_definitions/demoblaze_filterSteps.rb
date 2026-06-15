# ============================================
# CONTEXTO (Given)
# ============================================
Given('I see the product {string} on the page') do |expected_product|
  product_name = find(:xpath, "//a[normalize-space()='#{expected_product}']", wait: 10).text
 
  expect(product_name).to eq(expected_product)
end

# ============================================
# ACCIONES (When)
# ============================================
When('I select the {string} category') do |category_name|
  current_url_before = current_url
 
  
  find(:xpath, "//a[@id='itemc' and normalize-space()='#{category_name}']", wait: 10).click
  sleep 3
  
 
end

# ============================================
# VALIDACIONES (Then)
# ============================================
Then('I stay on the home page') do
  valid_urls = [
    'https://demoblaze.com/',
    'https://demoblaze.com/#',
    'https://demoblaze.com/index.html',
    'https://demoblaze.com/index.html#',
    'https://www.demoblaze.com/',
    'https://www.demoblaze.com/#',
    'https://www.demoblaze.com/index.html',
    'https://www.demoblaze.com/index.html#'
  ]
  
  expect(valid_urls).to include(current_url)
 
end

Then('I see the product {string} in the list') do |expected_product|
  product_name = find(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{expected_product}']", wait: 10).text
 
  expect(product_name).to eq(expected_product)
end