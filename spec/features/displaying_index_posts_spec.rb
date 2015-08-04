require 'rails_helper'

feature 'Displaying index posts' do
  background do
    create(:post, caption: 'This is post one')
    create(:post, caption: 'This is the second post')
    user = create :user

    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'the index lists all posts' do
    expect(page).to have_content('This is post one')
    expect(page).to have_content('This is the second post')
    expect(page).to have_css("img[src*='coffee']")
  end
end
