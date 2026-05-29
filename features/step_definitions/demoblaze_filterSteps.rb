Then('the product {string} should be visible before filtering') do |expected_product|
  product_name = find(:xpath, "//a[text()='#{expected_product}']", wait: 10).text

  puts "***PRODUCT BEFORE FILTERING: #{product_name}"

  if product_name != expected_product
    raise "Product before filtering is wrong. Expected: #{expected_product} Actual: #{product_name}"
  end
end

When('I click on the {string} category') do |category_name|
  current_url_before_click = current_url
  puts "***URL BEFORE FILTER: #{current_url_before_click}"

  find(:xpath, "//a[@id='itemc' and text()='#{category_name}']", wait: 10).click

  sleep 2

  current_url_after_click = current_url
  puts "***URL AFTER FILTER: #{current_url_after_click}"
end

Then('the page should remain on Demoblaze home') do
  valid_urls = [
    'https://demoblaze.com/',
    'https://demoblaze.com/#'
  ]

  unless valid_urls.include?(current_url)
    raise "The page was reloaded or changed. Expected URL: #{valid_urls.join(' or ')} Actual URL: #{current_url}"
  end

  puts "***PAGE REMAINED ON DEMOBLAZE HOME: #{current_url}"
end

Then('the product {string} should be visible in the category list') do |expected_product|
  product_name = find(:xpath, "//a[normalize-space(text())='#{expected_product}']", wait: 10).text

  puts "***CATEGORY PRODUCT FOUND: #{product_name}"

  if product_name != expected_product
    raise "Filtered product is wrong. Expected: #{expected_product} Actual: #{product_name}"
  end
end