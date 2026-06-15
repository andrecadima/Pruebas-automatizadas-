# ============================================
# NAVEGACIÓN CON LOGO
# ============================================
When('I click on the logo') do
  find(:css, '#nava', wait: 10).click
  sleep 1
  
end

Then('I should be redirected to the home page') do
  expected_urls = [
    'https://demoblaze.com/',
    'https://demoblaze.com/index.html',
    '/',
    'https://www.demoblaze.com/index.html',
    'https://www.demoblaze.com/'
  ]
  expect(expected_urls).to include(current_url)
  
end

# ============================================
# VALIDACIONES DE CARRITO
# ============================================
Then('I should be on the cart page') do
  expect(page).to have_selector('h2', text: 'Products', wait: 10)
  
end

Then('the cart should still contain the added items') do
  visit '/cart.html'
  sleep 1
  expect(page).to have_selector(:xpath, "//td[text()='Samsung galaxy s6']", wait: 10)
  
end

# ============================================
# VALIDACIONES DE PRODUCTO
# ============================================
Then('I should be on the product detail page for {string}') do |product_name|
  expect(page).to have_selector('h2', text: product_name, wait: 10)
  puts "***ON PRODUCT DETAIL PAGE: #{product_name}"
end

Then('the product detail page should be closed') do
  expect(page).to have_no_selector('h2', text: 'Samsung galaxy s6', wait: 5)
  
end

# ============================================
# VALIDACIONES DE MODALES
# ============================================
Then('the contact modal should be closed') do
  expect(page).to have_no_selector('#exampleModal', visible: true, wait: 5)
  
end

# ============================================
# AGREGAR PRODUCTO AL CARRITO (reutilizable)
# ============================================
When('I add the product {string} to the cart') do |product|
  visit '/'
  sleep 1
  find(:xpath, "//a[normalize-space(text())='#{product}']", wait: 10).click
  expect(page).to have_selector('h2', text: product, wait: 10)
  find(:xpath, "//a[contains(@class, 'btn') and text()='Add to cart']", wait: 10).click
  sleep 1
  begin
    page.driver.browser.switch_to.alert.accept
    
  rescue
   
  end
  visit '/'
  sleep 1
end