require 'rails_helper'

feature 'editing user profiles' do
  background do
    user = create(:user, user_name: 'Ferdynand')
    user2 = create(:user, id: 2, email: 'full@mocny.com', user_name: 'Fullmocny')
    post = create(:post, user_id: user.id)
    post2 = create(:post, user_id: 2, caption: 'good luck with that!' )
    sign_in_with user
    visit '/'
  end

  scenario 'a user can change their own profile details' do
    # Click the first user's user name
    click_link 'Ferdynand', match: :first
    click_link 'Edit Profile'
    # Select the new image.
    attach_file('user_avatar', 'spec/fixtures/images/coffee.png')
    fill_in 'user_bio', with: 'Where is my beer Halinka?'
    click_button 'Update Profile'

    expect(page.current_path).to eq(profile_path('Ferdynand'))
    expect(page).to have_css("img[src*='avatar']")
    expect(page).to have_content('Where is my beer Halinka?')
  end

  scenario 'a user cannot change someone elses profile picture' do
    click_link 'Fullmocny', match: :first
    # Expect to not see the 'edit profile' button.
    expect(page).to_not have_content('Edit Profile')
  end

  scenario "a user cannot navigate directly to edit a users profile" do
    # Directly visit another user’s edit url.
    visit '/Fullmocny/edit'
    expect(page).not_to have_content('Change your profile image:')
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content("That profile doesn't belong to you!")
  end
end
