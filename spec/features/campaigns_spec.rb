require 'rails_helper'

RSpec.feature "Campaigns", type: :feature do

  describe "Home Page" do
    it "displays a welcome message" do
      visit campaigns_path
      expect(page).to have_text("Welcome to Fund.sy")
    end

    it "has an HTML page title of 'Fund.sy'" do
      visit campaigns_path
      expect(page).to have_title("Fund.sy")
    end

    it "has an h2 element that says 'All Campaigns'" do
      visit campaigns_path
      expect(page).to have_selector("h2", "All Campaigns")
    end

    context "displaying campaigns" do
      # let! will always execute the statement in the let whether you call it or not.
      let!(:campaign) { create(:campaign) }

      it "displays the campaign title" do
        campaign = create(:campaign)
        visit campaigns_path
        expect(page).to have_text /#{campaign_title}/i
      end
    end

    context "displaying a single campaign" do
      let!(:campaign) { create(:campaign) }
      it "displays the campaign title in an h1 element" do
        visit campaigns_path
        expect(page).to have_selector("h1")
        expect(page).to have_text /#{campaign_title}/
      end

      it "displays the campaign body" do
        visit campaigns_path
        expect(page).to have_text /#{campaign_description}/i
      end
    end

  end

describe "Creating a campaign" do
  it "redirects to the campaign show page and adds a record to the DB" do
    login_via_web(user)
    before_count = Campaign.count
    visit new_campaign_path

    visit new_session_path

    fill_in "Email", with: user[:email]
    fill_in "Password", with: user[:password]
    click_button "Log in"

    valid_attributes = attributes_for(:campaign)

    fill_in "Title", with: valid_attributes[:title]
    fill_in "Description", with: valid_attributes[:description]
    fill_in "Goal", with: valid_attributes[:goal]

    click_on "Create Campaign"
    after_count = Campaign.count

    expect(current_path).to eq(campaign_path(Campaign.last))

  end
end
end
