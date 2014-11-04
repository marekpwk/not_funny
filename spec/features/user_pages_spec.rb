require 'spec_helper'

describe "User pages" do
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it{ expect(page).to have_content(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { expect(page).to have_selector('h1', text: 'Sign up') }
  end

  describe "edit page", type: :request do
    let(:user) { FactoryGirl.create(:user) }
    before  do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { expect(page).to have_selector('h2', text: "Update your profile") }
    end

    describe "with valid information" do
      let(:new_name) {"Yogi"}
      let(:new_email) {"yogi@example.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Save changes"
      end

      it { expect(page).to have_selector("div.alert-box.success") }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
