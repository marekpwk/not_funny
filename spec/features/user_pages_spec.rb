require 'spec_helper'

describe "User pages" do
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it{ expect(page).to have_content(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

   it { should have_content('Sign up') }
  end

  describe "edit page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { expect(page).to have_selector('h2', text: "Update your profile") }
    end 
  end
end
