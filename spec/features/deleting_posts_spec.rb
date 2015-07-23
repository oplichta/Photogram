require 'rails_helper'

feature 'Editing posts' do
  background do
    post = create(:post, caption: 'Coffee time #coffee')
    visit '/'
    find(:xpath, "//a[contains(@href,\"posts/#{post.id}\")]").click
    click_link 'Edit Post'
  end
  scenario do
    click_link 'Delete Post'

    expect(page).to have_content('Post was successfully destroyed.')
    expect(page).to_not have_content('Coffee time #coffee')
  end
end
