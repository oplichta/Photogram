require 'rails_helper'

feature 'viewing user profiles' do
  background do
    user = create(:user, user_name: 'Ferdynand')
    user2 = create(:user, id: 2, email: 'good@luck.com', user_name: 'goodluck')
    post = create(:post, user_id: user.id, caption: 'Where is my beer?')
    post2 = create(:post, user_id: 2, caption: 'good luck with that!' )

    sign_in_with user
    visit '/'
    click_link 'Ferdynand', match: :first
  end

  scenario 'visiting a profile page shows the user name in the url' do
    expect(page.current_path).to eq(profile_path('Ferdynand'))
  end

  scenario "a profile page only shows the specified user's posts" do
    expect(page).to have_content('Where is my beer?')
    expect(page).to_not have_content('good luck with that!')
  end
end
