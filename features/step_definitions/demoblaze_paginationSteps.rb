# ============================================
# CONTEXTO
# ============================================
Given('I am on the first page of products') do
  visit '/'
  sleep 2
  
end

# ============================================
# VERIFICAR PRODUCTOS VISIBLES
# ============================================
Then('I see these products on the page:') do |table|
  expected_products = table.raw.flatten
  
  sleep 2
  
  visible_products = all(:xpath, "//div[@id='tbodyid']//h4[@class='card-title']/a[@class='hrefch']", wait: 10).map(&:text)
  visible_products = visible_products.map(&:strip).reject(&:empty?)
  
  puts "***VISIBLE PRODUCTS (#{visible_products.count}): #{visible_products.join(', ')}"
  puts "***EXPECTED PRODUCTS (#{expected_products.count}): #{expected_products.join(', ')}"
  
  expected_products.each do |product|
    expect(visible_products).to include(product), 
      "Expected '#{product}' not found. Visible: #{visible_products.join(', ')}"
    
  end
  
  expect(visible_products.count).to eq(expected_products.count)
  
end

# ============================================
# HACER CLIC EN BOTONES DE PAGINACIÓN
# ============================================
When('I click the {string} button') do |button|
  case button
  when "Next"
    find(:css, '#next2', wait: 10).click
  when "Previous"
    find(:css, '#prev2', wait: 10).click
  end
  sleep 2
  
end