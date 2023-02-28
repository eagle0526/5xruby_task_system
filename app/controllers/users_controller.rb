class UsersController < ApplicationController

  before_action :params_user, only: [:create, :update]
  # before_action :authenticate_user!, only: [:create]

  def new
    @user = User.new
  end

  def create    
    @user = User.new(params_user)

    if @user.save
      session[:task_mission] = @user.id
      redirect_to tasks_path, notice: "註冊成功"
    else
      render :new
    end

  end

  def login
    @user = User.new
  end


  private

  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end