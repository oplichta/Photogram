require 'rails_helper'

feature 'Creating posts' do
  background do
    user = create :user
    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
  scenario 'create a new post' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', 'spec/fixtures/images/coffee.png')
    fill_in 'Caption', with: '#coffeetime nom nom'
    click_button 'Create Post'
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='coffee']")
  end
  scenario 'a post needs an image' do
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: 'No picture because YOLO'
    click_button 'Create Post'
    expect(page).to have_content('Halt, you fiend! You need an image
    to post here!')
  end
end
