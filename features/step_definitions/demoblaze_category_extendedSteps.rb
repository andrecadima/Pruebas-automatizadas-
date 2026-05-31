When('I filter products by {string} category') do |category_name|
  puts "***FILTERING CATEGORY: #{category_name}"

  find(:xpath, "//a[@id='itemc' and normalize-space()='#{category_name}']", wait: 10).click

  # Demoblaze carga los productos con una petición async, por eso esperamos un poco.
  sleep 2

  puts "***CATEGORY SELECTED: #{category_name}"
end

Then('the catalog should remain on the main page') do
  valid_urls = [
    'https://demoblaze.com/',
    'https://demoblaze.com/index.html',
    'https://demoblaze.com/#',
    'https://demoblaze.com/index.html#'
  ]

  unless valid_urls.include?(current_url)
    raise "The page changed unexpectedly. Current URL: #{current_url}"
  end

  puts "***PAGE REMAINED ON MAIN CATALOG: #{current_url}"
end

Then('the product {string} should be displayed in the catalog') do |product_name|
  expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10)

  puts "***EXPECTED PRODUCT DISPLAYED: #{product_name}"
end

Then('the product {string} should not be displayed in the catalog') do |product_name|
  expect(page).to have_no_selector(:xpath, "//a[contains(@class, 'hrefch') and normalize-space()='#{product_name}']", wait: 10)

  puts "***UNEXPECTED PRODUCT NOT DISPLAYED: #{product_name}"
end