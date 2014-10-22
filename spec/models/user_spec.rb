require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Yogi Bear", email: "yogi@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}

  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:remember_token)}

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  

  describe "when email is not present" do
    before { @user.email= " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      emails = %W[use@foo,com user_ar_gmailm user@gmail.]
      emails.each do |invalid_email|
        @user.email = invalid_email
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end

