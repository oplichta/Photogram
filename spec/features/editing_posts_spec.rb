require 'rails_helper'

feature 'Editing posts' do
  background do
    user = create :user
    create(:post, user_id: user.id)

    sign_in_with user

    find(:xpath, "//a[contains(@href,\"posts/1\")]").click
    click_link 'Edit Post'
  end

  scenario 'edit a post' do
    fill_in 'Caption', with: "Oh god, you weren't meant to see this picture!"
    click_button 'Update Post'

    expect(page).to have_content('Post updated hombre.')
    expect(page).to have_content("Oh god, you weren't meant to see this picture!")
  end

  scenario 'needs an image to update a post' do
    attach_file('Image', 'spec/fixtures/images/coffee.png.zip')
    click_button 'Update Post'

    expect(page).to have_content('Something gone wrong... try again.')
  end
end
