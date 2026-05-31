And('I start with an empty Demoblaze cart') do
  page.execute_script('window.localStorage.clear();')
  page.execute_script('window.sessionStorage.clear();')

  visit 'https://demoblaze.com'

  expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch')]", wait: 10)

  puts "***DEMOBLAZE CART AND STORAGE CLEARED"
end

When('I add the following products to the cart:') do |table|
  products = table.hashes

  products.each do |row|
    product_name = row['Product']

    puts "***ADDING PRODUCT TO CART: #{product_name}"

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
end

When('I open the Demoblaze cart page') do
  click_link('Cart')

  sleep 3

  expect(page).to have_current_path('/cart.html', wait: 10)

  expect(page).to have_selector('#tbodyid', wait: 10)

  puts "***OPENED DEMOBLAZE CART PAGE"

  sleep 3
end

Then('the Demoblaze cart should contain these products:') do |table|
  products = table.hashes

  sleep 3

  cart_text = find(:css, '#tbodyid', wait: 10).text

  puts "***CART CONTENT:"
  puts cart_text

  products.each do |row|
    product_name = row['Product']

    unless cart_text.include?(product_name)
      raise "Product not found in cart. Expected product: #{product_name}. Cart content: #{cart_text}"
    end

    puts "***PRODUCT FOUND IN CART: #{product_name}"
  end
end