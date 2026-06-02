Before '@maximize' do
  page.driver.browser.manage.window.maximize
  puts "***BROWSER MAXIMIZED"
end

Before '@clean_cart' do
  visit 'https://demoblaze.com'
  page.execute_script('window.localStorage.clear();')
  page.execute_script('window.sessionStorage.clear();')
  visit 'https://demoblaze.com'
  puts "***DEMOBLAZE LOCAL STORAGE AND SESSION STORAGE CLEARED"
end

After '@handle_alerts' do
  begin
    alert = page.driver.browser.switch_to.alert
    puts "***CLOSING REMAINING ALERT: #{alert.text}"
    alert.accept
  rescue Selenium::WebDriver::Error::NoSuchAlertError
    puts "***NO ALERT LEFT OPEN"
  rescue StandardError => e
    puts "***ERROR HANDLING ALERT: #{e.message}"
  end
end

After do |scenario|
  if scenario.failed?
    timestamp = Time.now.strftime('%Y-%m-%d-%H-%M-%S')
    scenario_name = scenario.name.gsub(/[^A-Za-z0-9]/, '_')

    Dir.mkdir('reports') unless Dir.exist?('reports')

    screenshot_path = "reports/#{scenario_name}_#{timestamp}.png"
    html_path = "reports/#{scenario_name}_#{timestamp}.html"

    save_screenshot(screenshot_path)
    save_page(html_path)

    puts "***FAILED SCENARIO SCREENSHOT SAVED: #{screenshot_path}"
    puts "***FAILED SCENARIO HTML SAVED: #{html_path}"
  end
end

After do
  Capybara.current_session.driver.quit
end