require 'twilio-ruby'
class Admin::DemotsController < ApplicationController
  include ApplicationHelper
  require 'will_paginate/array'
  helper_method :sort_column, :sort_direction
  before_filter :signed_in_user, only: [:new, :create, :up, :down, :destroy]
  before_filter :admin_user
  # respond_to :html, :js
  def index
    if params[:search]
      @demots = Demot.search(params[:search]).order(sort_column + "  " +  sort_direction).paginate(:page => params[:page], :per_page => 10)
    else
      @demots = Demot.order(sort_column(default="approved") + "  " +  sort_direction).paginate(:page => params[:page], :per_page => 10)
    end
  end

  def new
    @demot = Demot.new
  end

  def create
    # binding.pry
    @demot = Demot.new(demot_params)
    # binding.pry
    if @demot.save
      redirect_to demots_path, notice: "Your demot has been created"
    else
      flash.now[:alert] = "Ooops, all fields are required"
      render 'new'
    end
  end

  def destroy
    @demot = Demot.find(params[:id])
    @demot.destroy
    respond_to do |format|
      format.js
    end
  end

  def edit
    @demot = Demot.find(params[:id])
  end

  def up
    # binding.pry
    @demot = Demot.find(params[:id])
    vote = Vote.create(demot_id: @demot.id, user_id: params[:user_id])
    new_data = {demot_id: @demot.id}
    respond_to do |format|
      format.js
    end
  end

  def down
    @demot = Demot.find(params[:id])
    # binding.pry
    vote = Vote.where(user_id: params[:user_id], demot_id: @demot.id)[0]
    if vote
      vote.destroy
    end

    new_data = {demot_id: @demot.id}
    respond_to do |format|
      format.js
    end
  end

  def approve
    # binding.pry
    @demot = Demot.find(params[:id])
    message = ""
    if @demot.approved
      message = "Your meme has been approved :)"
      @demot.approved = false
    else
      message = "Sorry, but your meme has not been approved :("
      @demot.approved = true
    end

    @demot.save
    if @demot.mms
      # binding.pry
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      @client = Twilio::REST::Client.new account_sid, auth_token
      @client.account.sms.messages.create(:body => "Your meme has been approved.",
                                          :to => ENV['MY_NUMBER'],
                                          :from => ENV['TWILIO_NUMBER'])# In trial account you can only send messages to verified phone number
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def demot_params
    params.require(:demot).permit(:title, :image, :user_id)
  end
end
