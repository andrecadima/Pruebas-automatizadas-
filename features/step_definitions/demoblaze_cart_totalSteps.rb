When('I add products with prices to the cart:') do |table|
  products = table.hashes

  @expected_cart_total = 0

  products.each do |row|
    product_name = row['Product']
    product_price = row['Price'].to_i

    @expected_cart_total += product_price

    puts "***ADDING PRODUCT TO CART: #{product_name}"
    puts "***EXPECTED PRODUCT PRICE: #{product_price}"

    # Click en el producto
    find(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10).click

    # Esperar página del producto
    expect(page).to have_selector(:css, '.name', wait: 10)

    actual_product_name = find(:css, '.name', wait: 10).text

    if actual_product_name != product_name
      raise "Wrong product detail page. Expected: #{product_name} Actual: #{actual_product_name}"
    end

    # Agregar al carrito
    find(:xpath, "//a[normalize-space()='Add to cart']", wait: 10).click

    # Manejar alerta
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

    sleep 2
    
    # IMPORTANTE: Verificar que el producto está en el carrito ANTES de continuar
    visit '/cart.html'
    sleep 2
    cart_text = find(:css, '#tbodyid', wait: 10).text
    
    if cart_text.include?(product_name)
      puts "***PRODUCT CONFIRMED IN CART: #{product_name}"
    else
      raise "ERROR: Product #{product_name} was not added to cart successfully"
    end
    
    # Volver a la home page
    visit '/'
    sleep 2

    puts "***PRODUCT ADDED SUCCESSFULLY: #{product_name}"
  end

  puts "***EXPECTED CART TOTAL: #{@expected_cart_total}"
end

Then('the cart total should be {int}') do |expected_total|
  visit '/cart.html'
  sleep 3

  total_element = find(:css, '#totalp', wait: 10)
  actual_total = total_element.text.strip.to_i

  # También mostrar los productos en el carrito para depuración
  cart_text = find(:css, '#tbodyid', wait: 10).text
  puts "***CART CONTENTS: #{cart_text}"

  puts "***EXPECTED CART TOTAL: #{expected_total}"
  puts "***ACTUAL CART TOTAL: #{actual_total}"

  if actual_total != expected_total
    raise "Cart total is wrong. Expected: #{expected_total} Actual: #{actual_total}"
  end

  
end