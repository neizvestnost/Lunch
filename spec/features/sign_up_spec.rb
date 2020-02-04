require 'rails_helper'

RSpec.feature "Sign up", type: :feature do
  scenario "successfully" do
    visit new_user_registration_path

    fill_in 'Name', with: 'Test'
    fill_in 'Email', with: 'test@google.com'
    fill_in 'Password', with: '0123456'

    click_button "GO"
    expect(page).to have_text(User.last.api_token)
  end

  scenario "unsuccessfully" do
    visit new_user_registration_path

    fill_in 'Name', with: 'Test'
    fill_in 'Email', with: 'test@google.com'
    fill_in 'Password', with: '0123'

    click_button "GO"
    expect(page).to have_text("Password is too short")
  end
end
