

When('I add these products to the cart:') do |table|
  products = table.hashes

  products.each do |row|
    product_name = row['Product']

    

    expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10)

    find(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10).click

    expect(page).to have_selector(:css, '.name', wait: 10)

    actual_product_name = find(:css, '.name', wait: 10).text

    if actual_product_name != product_name
      raise "Wrong product page. Expected: #{product_name} Actual: #{actual_product_name}"
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
    

    unless actual_alert == 'Product added' || actual_alert == 'Product added.'
      raise "Wrong alert. Expected: Product added Actual: #{actual_alert}"
    end

    alert.accept
    sleep 3
    visit '/'
    sleep 3
    expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch')]", wait: 10)
    
  end
end


Then('I should see these products in the cart:') do |table|
  products = table.hashes
  sleep 3
  cart_text = find(:css, '#tbodyid', wait: 10).text
  
  puts cart_text

  products.each do |row|
    product_name = row['Product']
    unless cart_text.include?(product_name)
      raise "Product not found. Expected: #{product_name}. Cart content: #{cart_text}"
    end
    
  end
end