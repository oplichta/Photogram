require 'rails_helper'

feature 'User authentication' do
  background do
    @user = create(:user)
  end

  scenario 'log in from the index via dynamic navbar' do
    visit '/'
    expect(page).to_not have_content('New Post')
    click_link 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to_not have_content('Register')
    expect(page).to have_content('Logout')
  end

  scenario 'log out once logged in' do
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    click_link 'Logout'

    expect(page).not_to have_content('Logout')
  end

  scenario 'cannot create a new post without logging in' do
    visit new_post_path
    expect(page).to have_content('You need to sign in')
  end
end
