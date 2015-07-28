require 'rails_helper'

feature 'Display individual posts' do
  background do
    user = create :user
    create(:post, user_id: user.id)

    sign_in_with user
  end
  scenario 'click and view a single post from the index' do
    find(:xpath, "//a[contains(@href,\"posts/1\")]").click
    expect(page.current_path).to eq(post_path(1))
  end
end
