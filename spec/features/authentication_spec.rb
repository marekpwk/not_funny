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
        # it { should_not have_selector('div.alert-box.alert') }
        it "should not have error message" do
          expect(page).to_not have_selector('div.alert-box.alert')
        end
      end
    end
  end
end
