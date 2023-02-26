class SessionsController < ApplicationController
  
  def create
    # render html: params

    email = params[:email]
    password = params[:password]

    # 加密
    user = User.login(email, password)

    if user
      # session
      session[:task_mission] = user.id
      redirect_to tasks_path, notice: "登入成功"
    else      
      redirect_to login_users_path, alert: "登入失敗"
    end

  end

  def destroy
    session[:task_mission] = nil
    redirect_to tasks_path, alert: "登出"
  end

end