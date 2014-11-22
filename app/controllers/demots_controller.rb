class DemotsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :up, :down]
  # respond_to :html, :js
  def index
    @demots = Demot.all
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
    redirect_to demots_path, notice: "Demot has been deleted"
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

  private
  def demot_params
    params.require(:demot).permit(:title, :image, :user_id)
  end
end
