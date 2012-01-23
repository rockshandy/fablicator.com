class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  
  def authenticate
    unless signed_in?
      #unauthorized access
      redirect_to root_path, :notice => 'Please login before doing that.'
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def current_user_with_auths
    @current_user ||= User.includes(:authorizations).find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end
  
  def providers
    Authorization::PROVIDERS
  end

  helper_method :current_user, :current_user_with_auths, :signed_in?, :providers

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
end
