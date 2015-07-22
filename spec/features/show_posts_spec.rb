require 'rails_helper'

feature 'show posts' do
  scenario 'when it click on it' do
    post = create(:post)

    visit '/'
    find(:xpath, "//a[contains(@herf, 'posts/1')]").click

    expect(page.current_path).to eq(post_path(post))
  end
end
