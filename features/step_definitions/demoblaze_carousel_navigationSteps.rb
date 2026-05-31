Then('the carousel should be visible') do
  expect(page).to have_selector('#carouselExampleIndicators', wait: 10)

  puts "***CAROUSEL DISPLAYED"
end

def current_carousel_image
  find('#carouselExampleIndicators .carousel-item.active img',
       visible: :all)[:src]
end

When('I click the next carousel button') do

  @previous_image = current_carousel_image

  find('.carousel-control-next').click

  sleep 2

  puts "***CLICKED NEXT"
end

When('I click the previous carousel button') do

  @previous_image = current_carousel_image

  find('.carousel-control-prev').click

  sleep 2

  puts "***CLICKED PREVIOUS"
end

Then('the carousel image should change') do

  current_image = current_carousel_image

  expect(current_image).not_to eq(@previous_image)

  puts "***CAROUSEL IMAGE CHANGED"
end