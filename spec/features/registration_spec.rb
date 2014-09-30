require "rails_helper"


describe "Signing up" do
  it "creates new user record in database" do
    expect(User.count).to eq(0)

    visit signup_path
    expect(page).to have_selector('h1', text: 'Sign up')
    fill_in "Name", with: "Yogi"
    fill_in "Email", with: "yogi@example.com"
    fill_in "Password", with: "foobar"
    fill_in "Confirmation", with: "foobar"
    
    click_button "Create my account"
    expect(User.count).to eq(1)
  end
end

