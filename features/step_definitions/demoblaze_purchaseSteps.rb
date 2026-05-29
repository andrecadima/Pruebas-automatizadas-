Then('I should see the product {string} in the cart') do |product_name|
  expect(page).to have_selector(:xpath, "//td[text()='#{product_name}']", wait: 10)
  puts "***PRODUCT #{product_name} IS IN CART"
end

When('I click on the {string} button') do |button_text|
  click_button(button_text)
  puts "***CLICKED ON BUTTON: #{button_text}"
end

Then('the place order modal should be displayed') do
  modal = find(:css, '#orderModal', wait: 10)
  expect(modal).to be_visible
  puts "***PLACE ORDER MODAL IS DISPLAYED"
end

When('I fill in the purchase form with:') do |table|
  data = table.rows_hash
  
  fill_in('name', with: data['Name'])
  fill_in('country', with: data['Country'])
  fill_in('city', with: data['City'])
  fill_in('card', with: data['Credit Card'])
  fill_in('month', with: data['Month'])
  fill_in('year', with: data['Year'])
  
  puts "***PURCHASE FORM COMPLETED FOR: #{data['Name']}"
end

Then('the success message should be {string}') do |expected_message|
  sweet_alert = find(:css, '.sweet-alert', wait: 10)
  expect(sweet_alert).to be_visible
  
  actual_message = sweet_alert.find('h2').text
  expect(actual_message).to eq(expected_message)
  puts "***SUCCESS MESSAGE: #{actual_message}"
  
  sweet_alert.find('button', text: 'OK').click
end

Then('I should be redirected to the home page') do
  expected_urls = ['https://demoblaze.com/', 'https://demoblaze.com/#', '/', 'https://demoblaze.com/index.html']
  expect(expected_urls).to include(current_url)
  puts "***REDIRECTED TO HOME: #{current_url}"
end