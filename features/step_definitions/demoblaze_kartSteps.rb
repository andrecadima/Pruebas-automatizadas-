When('I click on the {string} product') do |product_name|
  product_xpath = "//a[normalize-space(text())='#{product_name}']"

  find(:xpath, product_xpath, wait: 10).click

  puts "***PRODUCT CLICKED: #{product_name}"
end

Then('the product detail page should be displayed for {string}') do |expected_product|
  product_title_xpath = '/html/body/div[5]/div/div[2]/h2'

  product_title = find(:xpath, product_title_xpath, wait: 10).text

  puts "***PRODUCT DETAIL PAGE: #{product_title}"

  if product_title != expected_product
    raise "Product detail page is wrong. Expected: #{expected_product} Actual: #{product_title}"
  end
end

When('I click on the Add to cart button') do
  add_to_cart_xpath = '/html/body/div[5]/div/div[2]/div[2]/div/a'

  find(:xpath, add_to_cart_xpath, wait: 10).click

  puts "***ADD TO CART BUTTON CLICKED"
end