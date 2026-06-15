Then('I should see the product {string} in the cart') do |product_name|
  expect(page).to have_selector(:xpath, "//td[normalize-space()='#{product_name}']", wait: 10)
  
end

When('I click on the {string} button') do |button_text|
  find(:xpath, "//button[normalize-space()='#{button_text}']", wait: 10).click
puts "***CLICKED ON BUTTON: #{button_text}"
end

Then('the place order modal should be displayed') do
  modal = find(:css, '#orderModal', visible: true, wait: 10)
  expect(modal).to be_visible

end

When('I fill in the purchase form with:') do |table|
  data = table.rows_hash

  find(:css, '#name', wait: 10).set(data['Name'])
  find(:css, '#country', wait: 10).set(data['Country'])
  find(:css, '#city', wait: 10).set(data['City'])
  find(:css, '#card', wait: 10).set(data['Credit Card'])
  find(:css, '#month', wait: 10).set(data['Month'])
  find(:css, '#year', wait: 10).set(data['Year'])


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

end

Then('I should remain on the cart page after purchase') do
  valid_urls = [
    'https://demoblaze.com/cart.html',
    'https://www.demoblaze.com/cart.html'
  ]

  unless valid_urls.include?(current_url)
    raise "Wrong page after purchase. Expected one of: #{valid_urls.join(' or ')} Actual: #{current_url}"
  end


end