require 'spec_helper'

describe SessionsController do

  describe "signin page" do
    before { visit signin_path }

    it "renders the new template" do
      expect(page).to have_selector('h1', text: 'Sign in')
    end
  end

  describe "with valid information" do
    subject {page}
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "Email", with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
    it { should have_link("Sign Out")}
  end


end
