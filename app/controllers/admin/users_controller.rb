class Admin::UsersController < ApplicationController
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :signed_in_user, only: [:index,:edit, :update]
  before_filter :admin_user

  def index
    if params[:search]
      @users = User.search(params[:search]).order(sort_column + "  " +  sort_direction).paginate(:page => params[:page], :per_page => 10)
    else
      @users = User.order(sort_column + "  " +  sort_direction).paginate(:page => params[:page], :per_page => 10)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if  @user.save
      sign_in @user
      flash[:success] = "Welcome to Not Funny"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Ooops check all required fields"
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.js
    end
  end

  def update
    # binding.pry
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.js
      else
        format.js { render :action => "edit" }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
