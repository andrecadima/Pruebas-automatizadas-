When('I click the {string} main navigation option') do |menu_option|
  puts "***CLICKING MAIN NAVIGATION OPTION: #{menu_option}"

  case menu_option
  when 'Home'
    click_link('Home')
  when 'Contact'
    click_link('Contact')
  when 'About us'
    click_link('About us')
  when 'Cart'
    click_link('Cart')
  when 'Log in'
    click_link('Log in')
  when 'Sign up'
    click_link('Sign up')
  else
    raise "Unknown menu option: #{menu_option}"
  end

  sleep 2

  puts "***CLICKED MAIN NAVIGATION OPTION: #{menu_option}"
end

Then('the {string} main navigation result should be displayed') do |menu_option|
  case menu_option
  when 'Home'
    valid_urls = [
      'https://demoblaze.com/',
      'https://demoblaze.com/index.html',
      'https://demoblaze.com/#',
      'https://demoblaze.com/index.html#',
      'https://www.demoblaze.com/',
      'https://www.demoblaze.com/index.html',
      'https://www.demoblaze.com/#',
      'https://www.demoblaze.com/index.html#'
    ]

    unless valid_urls.include?(current_url)
      raise "Home navigation failed. Current URL: #{current_url}"
    end

    expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch')]", wait: 10)

    puts "***HOME PAGE DISPLAYED CORRECTLY"
    puts "***CURRENT URL: #{current_url}"

  when 'Contact'
    modal = find(:css, '#exampleModal', visible: true, wait: 10)
    expect(modal).to be_visible

    within('#exampleModal') do
      expect(page).to have_content('New message')
      expect(page).to have_selector('#recipient-email', wait: 10)
      expect(page).to have_selector('#recipient-name', wait: 10)
      expect(page).to have_selector('#message-text', wait: 10)
    end

    puts "***CONTACT MODAL DISPLAYED CORRECTLY"

  when 'About us'
    modal = find(:css, '#videoModal', visible: true, wait: 10)
    expect(modal).to be_visible

    within('#videoModal') do
      expect(page).to have_content('About us')
      expect(page).to have_selector('video, iframe, .video-js', wait: 10)
    end

    puts "***ABOUT US MODAL DISPLAYED CORRECTLY"

  when 'Cart'
    expect(page).to have_current_path('/cart.html', wait: 10)
    expect(page).to have_selector('#tbodyid', wait: 10)

    puts "***CART PAGE DISPLAYED CORRECTLY"

  when 'Log in'
    modal = find(:css, '#logInModal', visible: true, wait: 10)
    expect(modal).to be_visible

    within('#logInModal') do
      expect(page).to have_content('Log in')
      expect(page).to have_selector('#loginusername', wait: 10)
      expect(page).to have_selector('#loginpassword', wait: 10)
    end

    puts "***LOG IN MODAL DISPLAYED CORRECTLY"

  when 'Sign up'
    modal = find(:css, '#signInModal', visible: true, wait: 10)
    expect(modal).to be_visible

    within('#signInModal') do
      expect(page).to have_content('Sign up')
      expect(page).to have_selector('#sign-username', wait: 10)
      expect(page).to have_selector('#sign-password', wait: 10)
    end

    puts "***SIGN UP MODAL DISPLAYED CORRECTLY"

  else
    raise "Unknown menu option validation: #{menu_option}"
  end
end