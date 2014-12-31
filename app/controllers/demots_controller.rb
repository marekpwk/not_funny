class DemotsController < ApplicationController
  require 'will_paginate/array'
  before_filter :signed_in_user, only: [:new, :create, :up, :down]
 
  def index
    @demots = Demot.order(updated_at: :desc).where(approved: true).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @demot = Demot.new
  end

  def create
    @demot = Demot.new(demot_params)
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
    redirect_to demots_path, notice: "Demot has been deleted"
  end

  def edit
    @demot = Demot.find(params[:id])
  end

  def up
    # binding.pry
    @demot = Demot.find(params[:id])
    vote = Vote.create(demot_id: @demot.id, user_id: params[:user_id])
    @demot.reload
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

    @demot.reload
    new_data = {demot_id: @demot.id}
    respond_to do |format|
      format.js
    end
  end

  def top
    @demots = Demot.order(total_votes: :desc).where(approved: true).first(50).paginate(:page => params[:page], :per_page => 10)
    render 'index'
  end

  private
  def demot_params
    params.require(:demot).permit(:title, :image, :user_id)
  end
end
