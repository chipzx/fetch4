require 'rails_helper'

feature 'angular test' do
  let (:group_name) { "fetchit" }
  let (:time_zone) { "UTC" }
  let (:email) { "admin@fetchitsoftware.com" }
  let (:password) { "password" }
  
  before do
    Group.create(name: :group_name,
                 time_zone: :time_zone)
    User.create(email: email,
                password: password,
                password_confirmation: password,
                group_id: 1,
                confirmed_at: Date.today)
  end

  scenario 'Welcome page is working' do
    visit "/"
    # Log In
    fill_in "Email", with: "admin@fetchitsoftware.com"
    fill_in "Password", with: "password"
    click_button "Log in" 

    expect(page).to have_content("Welcome")
    fill_in "motd", with: "Test message of the day"
    within 'header h3' do
      expect(page).to have_content('Test message of the day')
    end    
  end
end
