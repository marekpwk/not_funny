require 'spec_helper'

describe Demot do
  before do
    @user = FactoryGirl.create(:user)
    @demot = FactoryGirl.build(:demot, user_id: @user.id)
  end
  subject { @demot }
  
  it { should respond_to(:image) }
  it { should respond_to(:title) }
  it { should respond_to(:type) }
  it { should respond_to(:user) }

  describe "when image is not present" do
    before {@demot.image = ""}
    it { should_not be_valid }
  end
  describe "when user is not present" do
    before {@demot.user = nil}
    it { should_not be_valid }
  end
end
