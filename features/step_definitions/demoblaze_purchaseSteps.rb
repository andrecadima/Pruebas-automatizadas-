Then('I should see the product {string} in the cart') do |product_name|
  expect(page).to have_selector(:xpath, "//td[text()='#{product_name}']", wait: 10)
  puts "***PRODUCT #{product_name} IS IN CART"
end

When('I click on the {string} button') do |button_text|
  find(:xpath, "//button[text()='#{button_text}']", wait: 10).click
  puts "***CLICKED ON BUTTON: #{button_text}"
end

Then('the place order modal should be displayed') do
  modal = find(:css, '#orderModal', visible: true, wait: 10)
  expect(modal).to be_visible
  puts "***PLACE ORDER MODAL IS DISPLAYED"
end

When('I fill in the purchase form with:') do |table|
  data = table.rows_hash

  find(:css, '#name', wait: 10).set(data['Name'])
  find(:css, '#country', wait: 10).set(data['Country'])
  find(:css, '#city', wait: 10).set(data['City'])
  find(:css, '#card', wait: 10).set(data['Credit Card'])
  find(:css, '#month', wait: 10).set(data['Month'])
  find(:css, '#year', wait: 10).set(data['Year'])

  puts "***PURCHASE FORM COMPLETED FOR: #{data['Name']}"
end

Then('the success message should be {string}') do |expected_message|
  sweet_alert = find(:css, '.sweet-alert', visible: true, wait: 10)
  expect(sweet_alert).to be_visible

  actual_message = sweet_alert.find('h2', wait: 10).text

  puts "***SUCCESS MESSAGE: #{actual_message}"

  if actual_message != expected_message
    raise "Success message is wrong. Expected: #{expected_message} Actual: #{actual_message}"
  end

  sweet_alert.find('button', text: 'OK', wait: 10).click

  sleep 2
  puts "***SUCCESS MODAL CLOSED"
end

Then('I should remain on the cart page after purchase') do
  expected_url = 'https://demoblaze.com/cart.html'

  if current_url != expected_url
    raise "Wrong page after purchase. Expected: #{expected_url} Actual: #{current_url}"
  end

  puts "***REMAINED ON CART PAGE AFTER PURCHASE: #{current_url}"
end