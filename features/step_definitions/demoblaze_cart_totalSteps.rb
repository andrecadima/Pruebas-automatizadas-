When('I add products with prices to the Demoblaze cart:') do |table|
  products = table.hashes

  @expected_cart_total = 0

  products.each do |row|
    product_name = row['Product']
    product_price = row['Price'].to_i

    @expected_cart_total += product_price

    puts "***ADDING PRODUCT TO CART: #{product_name}"
    puts "***EXPECTED PRODUCT PRICE: #{product_price}"

    expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10)

    find(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10).click

    expect(page).to have_selector(:css, '.name', wait: 10)

    actual_product_name = find(:css, '.name', wait: 10).text

    if actual_product_name != product_name
      raise "Wrong product detail page. Expected: #{product_name} Actual: #{actual_product_name}"
    end

    find(:xpath, "//a[normalize-space()='Add to cart']", wait: 10).click

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

    sleep 3

    visit 'https://demoblaze.com'

    sleep 3

    expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch')]", wait: 10)

    puts "***PRODUCT ADDED SUCCESSFULLY: #{product_name}"
  end

  puts "***EXPECTED CART TOTAL: #{@expected_cart_total}"
end

Then('the Demoblaze cart total should be equal to the expected total') do
  sleep 3

  total_element = find(:css, '#totalp', wait: 10)
  actual_total = total_element.text.strip.to_i

  puts "***EXPECTED CART TOTAL: #{@expected_cart_total}"
  puts "***ACTUAL CART TOTAL: #{actual_total}"

  if actual_total != @expected_cart_total
    raise "Cart total is wrong. Expected: #{@expected_cart_total} Actual: #{actual_total}"
  end

  puts "***CART TOTAL IS CORRECT"
end