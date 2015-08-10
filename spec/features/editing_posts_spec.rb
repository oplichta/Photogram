require 'rails_helper'

feature 'Editing posts' do
  background do
    user = create :user
    user_two = create :user
    create(:post, user_id: user.id)
    create(:post, user_id: user_two.id)
    sign_in_with user
    visit '/'
  end

  scenario 'edit a post as the owner' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page).to have_content('Edit Post')

    click_link 'Edit Post'
    fill_in 'post_caption', with: "Oh god, you weren't meant to see this picture!"
    click_button 'Update Post'

    expect(page).to have_content('Post updated hombre')
    expect(page).to have_content("Oh god, you weren't meant to see this picture!")
  end

  scenario "cannot edit a post that doesn't belong to you via the show page" do
    find(:xpath, "//a[contains(@href,'posts/2')]").click
    expect(page).to_not have_content('Edit Post')
  end

  scenario "cannot edit a post that doesn't belong to you via url path" do
    visit '/posts/2/edit'
    expect(page.current_path).to eq root_path
    expect(page).to have_content("That post doesn't belong to you!")
  end

  scenario 'needs an image to update a post' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
    attach_file('post_image', 'spec/fixtures/images/coffee.png.zip')

    click_button 'Update Post'

    expect(page).to have_content('Something gone wrong... try again.')
  end
end
