class Admin::DemotsController < ApplicationController
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :signed_in_user, only: [:new, :create, :up, :down]
  before_filter :admin_user
  # respond_to :html, :js
  def index
    @demots = Demot.order(sort_column + "  " +  sort_direction).paginate(:page => params[:page], :per_page => 10)
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

  private
  def demot_params
    params.require(:demot).permit(:title, :image, :user_id)
  end

  def sort_column
    Demot.column_names.include?(params[:sort]) ? params[:sort] : "id"

    params[:sort] || "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
