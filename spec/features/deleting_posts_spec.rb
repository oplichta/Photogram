require 'rails_helper'

feature 'Deleting posts' do
  background do
    user = create :user
    create(:post, caption: 'Coffee time #coffee', user_id: user.id)
    sign_in_with user
    find(:xpath, "//a[contains(@href,\"posts/1\")]").click
    click_link 'Edit Post'
  end
  scenario do
    click_link 'Delete Post'

    expect(page).to have_content('Post was successfully destroyed.')
    expect(page).to_not have_content('Coffee time #coffee')
  end
end
