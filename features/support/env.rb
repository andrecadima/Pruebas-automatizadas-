require 'selenium-webdriver'
begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'dotenv'

Dotenv.load

# Configuración de Capybara
Capybara.default_max_wait_time = 15
Capybara.run_server = false

# URL base desde variable de entorno o por defecto
BASE_URL = ENV['BASE_URL'] || 'https://www.demoblaze.com'
Capybara.app_host = BASE_URL

# Registrar driver de Chrome
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,900')
  
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :selenium_chrome

# Limpiar cookies después de cada escenario
After do
  page.driver.browser.manage.delete_all_cookies
end

Capybara::Screenshot.autosave_on_failure = true