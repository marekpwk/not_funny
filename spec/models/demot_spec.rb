require 'rails_helper'

describe Demot do
  before :each do
    @user = FactoryGirl.create(:user)
    @demot = FactoryGirl.build(:demot, user_id: @user.id)
  end

  it "is invalid without user" do
    @demot.user = nil
    expect(@demot).to_not be_valid
  end

  it "is invalid without title" do
    @demot.title = nil
    expect(@demot).to_not be_valid
  end

  it "is invalid without image" do
    @demot = FactoryGirl.build(:demot, image: nil,  user_id: @user.id)
    @demot.image = nil
    @demot.save
    expect(@demot).to_not be_valid
  end

  describe "with comments" do
    it "should increase commments count" do
      @demot.save
      @demot.comments.build( user_id: @user.id, body: "test")
      @demot.save
      expect(@demot.comments.count).to eq 1
    end

    it "should delete all commments after deleteing demot" do
      @demot.save
      @demot.comments.build(user_id: @user.id, body: "test")
      @demot.save
      demot_id = @demot.id
      @demot.destroy
      expect(Comment.where(commentable_id: demot_id).count).to eq 0
    end
  end

  describe "with votes" do
    before :each do
      @vote = Vote.create(user: @user, demot: @demot)
    end

    it "should increase votes count" do
      @demot.save
      expect(@demot.total_votes).to eq 1
    end
  end

  describe "search by title" do
    before :each do
      @ruby = @demot
      @ruby.save
      @javascript = FactoryGirl.build(:demot, user: @user, title: "Javascript")
      @javascript.save
      @rails = FactoryGirl.build(:demot, user: @user, title: "Ruby on Rails")
      @rails.save
    end

    it "should find demot with  matchin title" do
      expect(Demot.search("ruby")[0].title).to eq "Ruby"
    end

    it "should find demots with  matchin title" do
      expect(Demot.search("ruby")).to eq [@ruby, @rails]
    end

    it "should not find demots" do
      expect(Demot.search("python").count).to eq 0
    end
  end
end
