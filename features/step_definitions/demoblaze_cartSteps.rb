# ============================================
# AGREGAR UN SOLO PRODUCTO
# ============================================
When('I add the product {string} to the cart') do |product|
  if product == "Samsung galaxy s6" || product == "Nokia lumia 1520" || product == "Nexus 6"
    visit '/'
    sleep 1
  end
  
  find(:xpath, "//a[normalize-space(text())='#{product}']", wait: 10).click
  expect(page).to have_selector('h2', text: product, wait: 10)
  find(:xpath, "//a[contains(@class, 'btn') and text()='Add to cart']", wait: 10).click
  
  sleep 1
  begin
    page.driver.browser.switch_to.alert.accept
    puts "***ADDED: #{product}"
  rescue
    puts "***ADDED: #{product} (no alert)"
  end
  
  visit '/'
  sleep 1
  puts "***RETURNED TO HOME"
end

# ============================================
# CAMBIAR DE CATEGORÍA
# ============================================
When('I change to the {string} category') do |category|
  unless current_url == 'https://demoblaze.com/' || current_url == 'https://demoblaze.com/index.html'
    visit '/'
    sleep 1
  end
  
  find(:xpath, "//a[@id='itemc' and text()='#{category}']", wait: 10).click
  sleep 1
  puts "***CATEGORY CHANGED: #{category}"
end

# ============================================
# VERIFICAR MÚLTIPLES PRODUCTOS EN CARRITO
# ============================================
Then('the cart should contain the following products:') do |table|
  products = table.raw.flatten
  
  sleep 3
  
  products.each do |product|
    expect(page).to have_selector(:xpath, "//td[text()='#{product}']", wait: 10)
    puts "***VERIFIED: #{product} is in cart"
  end
  
  total_products = all(:xpath, "//tbody/tr").count
  puts "***TOTAL PRODUCTS IN CART: #{total_products}"
  expect(total_products).to eq(products.count)
end

# ============================================
# VERIFICAR TOTAL DEL CARRITO (CORREGIDO)
# ============================================
Then('the cart total should be {string}') do |expected_total|
  sleep 1
  total_element = find(:css, '#totalp', wait: 10)
  actual_total = total_element.text
  
  expect(actual_total).to eq(expected_total)
  puts "***CART TOTAL: #{actual_total} (Expected: #{expected_total})"
end

# ============================================
# RECARGAR PÁGINA
# ============================================
When('I reload the page') do
  visit current_url
  sleep 2
  expect(page).to have_selector('#tbodyid', wait: 10)
  puts "***PAGE RELOADED AND CART LOADED"
end

# ============================================
# VERIFICAR CANTIDAD DE PRODUCTOS DESPUÉS DE RECARGAR
# ============================================
Then('the cart should still contain {int} products') do |expected_count|
  sleep 2
  expect(page).to have_selector('#tbodyid', wait: 10)
  total_products = all(:xpath, "//tbody/tr").count
  expect(total_products).to eq(expected_count)
  puts "***PRODUCTS AFTER RELOAD: #{total_products}"
end

# ============================================
# VERIFICAR TOTAL DESPUÉS DE RECARGAR (CORREGIDO)
# ============================================
Then('the cart total should still be {string}') do |expected_total|
  total_element = find(:css, '#totalp', wait: 10)
  actual_total = total_element.text
  expect(actual_total).to eq(expected_total)
  puts "***TOTAL AFTER RELOAD: #{actual_total}"
end

# ============================================
# ELIMINAR PRODUCTO DEL CARRITO
# ============================================
When('I delete the product {string} from the cart') do |product_name|
  unless page.has_selector?('#tbodyid')
    visit '/cart.html'
    sleep 1
  end
  
  delete_link = find(:xpath, "//td[text()='#{product_name}']/following-sibling::td/a[text()='Delete']", wait: 10)
  delete_link.click
  
  sleep 2
  puts "***DELETED: #{product_name}"
end