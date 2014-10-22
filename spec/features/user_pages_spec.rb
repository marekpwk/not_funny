require 'spec_helper'

describe "User pages" do
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it{ expect(page).to have_content(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

   xit { should have_content('Sign up') }
  end
end
