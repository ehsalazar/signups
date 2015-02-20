module SessionsHelper

 def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session[:user_id] = nil
    # redirect_to root_path
  end

end