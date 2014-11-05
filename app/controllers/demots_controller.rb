class DemotsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create]
  def index
    @demots = Demot.all
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

  private
  def demot_params
    params.require(:demot).permit(:title, :image, :user_id)
  end
end
