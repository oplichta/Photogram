require 'rails_helper'

feature 'Creating comments' do
  scenario 'on an existing post' do
    user = create(:user)
    post = create(:post, user_id: user.id)
    sign_in_with user
    visit '/'
    fill_in 'Add a comment...', with: ';P'
    click_button 'submit'
    expect(page).to have_css('div.comment-content', text: ';P')
  end
end
