require "rails_helper"

feature "Log in" do

	background do
    FactoryGirl.create(:user)
  end

  scenario "User visits secret page to log in" do

    visit root_path #'http://localhost:8080/auth/local/new'
    #save_and_open_page
    #click_link 'Login'
    #fill_in "Email", :with => "new"
    #fill_in "Password", :with => "password"
    #click_button "commit"

    #expect(page).to have_text("Widget was successfully created.")
  end
end
