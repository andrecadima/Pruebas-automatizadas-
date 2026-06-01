# ============================================
# VERIFICAR PRODUCTOS VISIBLES EN LA PÁGINA
# ============================================
Then('the page should display the following products:') do |table|
  expected_products = table.raw.flatten
  
  # Esperar a que los productos carguen
  sleep 2
  
  # Selector basado en la estructura HTML que compartiste
  visible_products = all(:xpath, "//div[@id='tbodyid']//h4[@class='card-title']/a[@class='hrefch']", wait: 10).map(&:text)
  
  # Limpiar espacios en blanco
  visible_products = visible_products.map(&:strip).reject(&:empty?)
  
  puts "***VISIBLE PRODUCTS (#{visible_products.count}): #{visible_products.join(', ')}"
  puts "***EXPECTED PRODUCTS (#{expected_products.count}): #{expected_products.join(', ')}"
  
  # Verificar que cada producto esperado está visible
  expected_products.each do |product|
    expect(visible_products).to include(product), 
      "Expected '#{product}' not found. Visible: #{visible_products.join(', ')}"
    puts "***VERIFIED: #{product}"
  end
  
  # Verificar cantidad exacta
  expect(visible_products.count).to eq(expected_products.count)
  puts "***PRODUCT COUNT MATCHES: #{visible_products.count}"
end

# ============================================
# HACER CLIC EN BOTONES DE PAGINACIÓN
# ============================================
When('I click the {string} pagination button') do |button|
  case button
  when "Next"
    find(:css, '#next2', wait: 10).click
  when "Previous"
    find(:css, '#prev2', wait: 10).click
  end
  sleep 2
  puts "***CLICKED PAGINATION BUTTON: #{button}"
end