require 'rails_helper'

describe "User registration" do

  it "allows new users to register with a username and password" do
    visit "/users/sign_up"

    fill_in "Username",              :with => "Garett Arrowood"
    fill_in "Password",              :with => "complicated_password"
    fill_in "Password confirmation", :with => "complicated_password"

    click_button "Sign up"

    expect(page).to have_content("Logged in as Garett Arrowood.")
  end

  let(:user) { create :user }

  it "allows users to log in after they have registered" do

    visit "/users/sign_in"

    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
  end

  describe "logging out" do

    before do
      login
    end

    it "allows users to logout" do

      visit '/'

      click_link "Logout"

      expect(page).to have_content("Signed out successfully.")
    end
  end
end
