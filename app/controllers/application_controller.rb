class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= (session[:user_id] ? User.find(session[:user_id]) : nil)
  end

  helper_method :current_user

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in. Log In."
      redirect_to login_path
    end
  end

  def logged_in?
    !!session[:user_id]
  end

  helper_method :logged_in?

  def login_required
    redirect_to login_path unless logged_in?
  end

end
