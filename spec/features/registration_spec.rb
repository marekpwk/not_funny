require "spec_helper"


describe "Signing up" do
  before { visit  signup_path  }

  describe "with invalid information" do
    it "should not create a user" do
      expect { click_button "Create my account" }.not_to change(User, :count)
    end

    describe "error messages" do
      before { click_button "Create my account" }
      it "should have a header signup" do
        expect(page).to have_selector('h1', text: 'Sign up')
      end

      it "has error  messasge" do
        expect(page).to have_selector('div.alert-box.alert', text: 'Ooops check all required fields')
      end
    end
  end

  describe "with valid information" do
    before do
      fill_in "Name", with: "Yogi"
      fill_in "Email", with: "yogi@example.com"
      fill_in "Password", with: "foobar"
      fill_in "Confirmation", with: "foobar"
    end

    it "creates new user record in database" do
      expect(page).to have_selector('h1', text: 'Sign up')
      expect{ click_button "Create my account" }.to change(User, :count).by(1)
    end

    describe "after saving the user" do
      before {click_button "Create my account"}
      let(:user) { User.find_by_email("yogi@example.com") }
      it "has welcome messasge" do
        expect(page).to have_selector('div.alert-box.success', text: 'Welcome to Not Funny')
      end

      it "has signout link" do
        expect(page).to  have_link('Sign out')
      end
    end
  end
end
