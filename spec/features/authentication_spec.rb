require 'spec_helper'

describe "Authentication" do
  describe "signin page" do
    before { visit signin_path }

    it "renders the new template" do
      expect(page).to have_selector('h1', text: 'Sign in')
    end
  end

  describe "signin"do
    before { visit signin_path }

    describe "with invalid information" do
      before{ click_button "Sign in" }

      it "renders new template again and displays error message" do
        expect(page).to have_selector('h1', text: "Sign in")
        expect(page).to have_selector("div.alert-box.alert")
      end

      describe "after visiting another page" do
        before { click_link "Not funny" }
        it "should not have error message" do
          expect(page).to_not have_selector('div.alert-box.alert')
        end
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it "has links visible to loggedin users" do
        expect(page).to have_link('Profile')
        expect(page).to have_link('Sign out')
        expect(page).to have_link('Settings')
      end

      it "doesnt have sigin link" do
        expect(page).to_not have_link('Sign in')
      end

      describe "followed by signout" do
        before { click_link "Sign out" }
        it "has sign in link" do
          expect(page).to have_link('Sign in')
        end
      end
    end
  end
end
