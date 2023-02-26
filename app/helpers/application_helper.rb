module ApplicationHelper

  def current_user
    @_user_ ||= User.find_by(id: session[:task_mission])
  end

  def user_signed_in?
    !!session[:task_mission]
  end

end
