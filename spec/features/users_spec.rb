require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "Signing up" do
    it "creates a user in the database and redirects to homepage" do
      visit new_user_path

      #This uses FactoryGirl and gives us a valid set of
      # user attributes that we can use! :D
      valid_attributes = attributes_for(:user)
      fill_in "first_name", with: valid_attributes[:first_name]
      fill_in "last_name", with: valid_attributes[:last_name]
      fill_in "email", with: valid_attributes[:email]
      fill_in "user_password", with: valid_attributes[:password]
      fill_in "user_password_confirmation", with: valid_attributes[:password]

      click_button "Create User"

      expect(current_path).to eq(root_path)
      expect(after_count - before_count).to eq(1)
      # This command will open up a web page with the current status
      # it requries the launchy gem to be installed
      save_and_open_page
    end

  end


end
