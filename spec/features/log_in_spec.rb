require "rails_helper"

feature "Log in" do

  background do
    FactoryGirl.create(:user)
  end

  scenario "User visits secret page to log in" do

    #visit 'http://localhost:1234/auth/local/new'
    #p "URL #{current_url}"
    #save_and_open_page
    #click_link 'Login'
    #fill_in "Email", :with => "new"
    #fill_in "Password", :with => "password"
    #click_button "commit"

    #expect(page).to have_text("Widget was successfully created.")
  end
end
