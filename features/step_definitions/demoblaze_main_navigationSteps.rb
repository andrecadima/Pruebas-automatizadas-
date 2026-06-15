When('I click on {string} from the menu') do |menu_option|
  
  click_link(menu_option)
  sleep 2
  
end

Then('I see the {string} section') do |menu_option|
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
    expect(valid_urls).to include(current_url)
    expect(page).to have_selector(:xpath, "//a[contains(@class, 'hrefch')]", wait: 10)
    

  when 'Contact'
    modal = find(:css, '#exampleModal', visible: true, wait: 10)
    expect(modal).to be_visible
    within('#exampleModal') do
      expect(page).to have_content('New message')
      expect(page).to have_selector('#recipient-email', wait: 10)
      expect(page).to have_selector('#recipient-name', wait: 10)
      expect(page).to have_selector('#message-text', wait: 10)
    end
  

  when 'About us'
    modal = find(:css, '#videoModal', visible: true, wait: 10)
    expect(modal).to be_visible
    within('#videoModal') do
      expect(page).to have_content('About us')
      expect(page).to have_selector('video, iframe, .video-js', wait: 10)
    end
  

  when 'Cart'
    expect(page).to have_current_path('/cart.html', wait: 10)
    expect(page).to have_selector('#tbodyid', wait: 10)
  

  when 'Log in'
    modal = find(:css, '#logInModal', visible: true, wait: 10)
    expect(modal).to be_visible
    within('#logInModal') do
      expect(page).to have_content('Log in')
      expect(page).to have_selector('#loginusername', wait: 10)
      expect(page).to have_selector('#loginpassword', wait: 10)
    end
  

  when 'Sign up'
    modal = find(:css, '#signInModal', visible: true, wait: 10)
    expect(modal).to be_visible
    within('#signInModal') do
      expect(page).to have_content('Sign up')
      expect(page).to have_selector('#sign-username', wait: 10)
      expect(page).to have_selector('#sign-password', wait: 10)
    end
  

  else
    raise "Unknown menu option: #{menu_option}"
  end
end