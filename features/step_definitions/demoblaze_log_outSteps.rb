Then('the welcome message should be visible before logout') do
  expected_message = "Welcome #{ENV['DEMOBLAZE_USER']}"

  expect(page).to have_selector(:css, '#nameofuser', wait: 2)

  actual_message = find(:css, '#nameofuser', wait: 2).text

  puts "***WELCOME MESSAGE BEFORE LOGOUT: #{actual_message}"

  if actual_message != expected_message
    raise "Wrong welcome message. Expected: #{expected_message} Actual: #{actual_message}"
  end
end

When('I click on Log out for logout validation') do
  expect(page).to have_selector(:css, '#logout2', wait: 2)

  find(:css, '#logout2', wait: 2).click

  sleep 3

  puts "***LOGOUT CLICKED"
end

Then('the Log in option should be visible after logout') do
  expect(page).to have_selector(:css, '#login2', wait: 2)

  puts "***LOG IN OPTION IS VISIBLE"
end

Then('the Sign up option should be visible after logout') do
  expect(page).to have_selector(:css, '#signin2', wait: 2)

  puts "***SIGN UP OPTION IS VISIBLE"
end

Then('the welcome message should not be visible after logout') do
  expect(page).to have_no_selector(:css, '#nameofuser', wait: 2)

  puts "***WELCOME MESSAGE IS NOT VISIBLE AFTER LOGOUT"
end