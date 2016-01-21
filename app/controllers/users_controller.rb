class UsersController < ApplicationController
  helper :headshot
  before_action :current_user_guard, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      User.current_user = User.find(session[:user_id])
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    @user = current_user
    render :dashboard
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
