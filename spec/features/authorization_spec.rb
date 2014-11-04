require 'spec_helper'

describe "Authorization", type: :request do
  describe "for non-signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    describe "visiting edit page" do
      before {visit edit_user_path(user)}
      it {expect(page).to have_selector("h1", text: "Sign in")}
    end

    describe "submitting to the update action" do
      before { put user_path(user) }
      specify { response.should redirect_to(signin_path) }
    end

    describe "when trying to visit edit page" do
      before do
        visit edit_user_path(user)
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      describe "after signed in" do
        it "should render edit page" do
          expect(page).to have_selector("h2", text: "Update your profile")
        end
      end
    end
  end

  describe "as invalid user" do
    let(:user){ FactoryGirl.create(:user) }
    let(:wrong_user){ FactoryGirl.create(:user, email: "invalid_user@examplec.com") }
    before { sign_in user }

    describe "visiting Users#edit page" do
      before { visit edit_user_path(wrong_user) }
      it { expect(page).to_not have_selector("h2", text: "Update your profile") }
    end

    describe "submitting a PUT request to the Users#update action" do
      before { put user_path(wrong_user) }
      specify { response.should redirect_to(root_path) }
    end
  end
end
