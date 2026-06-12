Then('I see the product {string} in the cart') do |product_name|
  cart_text = find(:css, '#tbodyid', wait: 10).text

  puts "***CART CONTENT:"
  puts cart_text

  unless cart_text.include?(product_name)
    raise "Product not found in cart. Expected: #{product_name}. Cart content: #{cart_text}"
  end

  puts "***PRODUCT FOUND: #{product_name}"
end

When('I delete the product {string} from the cart') do |product_name|
  puts "***DELETING PRODUCT: #{product_name}"

  delete_xpath = "//tr[td[normalize-space()='#{product_name}']]//a[normalize-space()='Delete']"

  expect(page).to have_selector(:xpath, delete_xpath, wait: 10)

  find(:xpath, delete_xpath, wait: 10).click

  sleep 4

  puts "***DELETE CLICKED FOR PRODUCT: #{product_name}"
end

Then('I should not see the product {string} in the cart') do |product_name|
  expect(page).to have_no_selector(:xpath, "//tbody[@id='tbodyid']//td[normalize-space()='#{product_name}']", wait: 10)

  cart_text = find(:css, '#tbodyid', wait: 10).text

  puts "***CART CONTENT AFTER DELETE:"
  puts cart_text

  if cart_text.include?(product_name)
    raise "Product still visible after delete. Product: #{product_name}. Cart content: #{cart_text}"
  end

  puts "***PRODUCT REMOVED: #{product_name}"
end

Given('my shopping cart is empty') do
  visit('/cart.html')
  begin
    while true
      find(:xpath, "//tbody[@id='tbodyid']//a[text()='Delete']").click
      sleep 2
    end
  rescue
    puts "***CART IS EMPTY"
  end
  visit('/')
  puts "***CART IS EMPTY"
end