require 'rails_helper'

feature 'Deleting comments' do
  background do
    user = create(:user)
    user_two = create(:user)
    post = create(:post, user_id: user_two.id)
    create(:comment, id: 1, user_id: user_two.id, post_id: post.id)
    create(:comment, id: 2, user_id: user.id, post_id: post.id, content: 'Superb photo!')
    sign_in_with user_two
  end

  scenario 'user can delete comments' do
    visit '/'
    expect(page).to have_content('Nice post!')
    click_link 'delete-1'
    expect(page).not_to have_content('Nice post!')
  end

  scenario 'cannot delete via the UI' do
    visit '/'
    expect(page).to have_content('Superb photo!')
    expect(page).not_to have_css('#delete-2')
  end

  scenario 'cannot delete not own comment' do
    visit '/'
    expect(page).to have_content('Superb photo!')
    page.driver.submit :delete, 'posts/1/comments/2', {}
    expect(page).to have_content("That doesn't belong to you!")
    expect(page).to have_content('Superb photo!')
  end
end
