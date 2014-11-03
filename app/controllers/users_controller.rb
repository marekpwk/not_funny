class UsersController < ApplicationController
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

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
