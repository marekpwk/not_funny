class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index,:edit, :update]
  before_filter :correct_user, only: [:show, :edit, :update]
  before_filter :admin_user, only: [:index]
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
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render "edit"
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

  def admin_user
    unless current_user.admin?
      redirect_to(root_path)
    end
  end
end
