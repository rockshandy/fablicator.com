class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  # TODO: see if can match widths for edit/view content of posts across tinymce and user display
  # TODO: add last updated timestamp with proper html5 markup to blog posts
  # TODO: increase default size of dialog upload box
  # TODO: look into video embed
  # TODO: get better favicon
  # TODO: make vector/gimp layer version of logo for infisizeing  
  def authenticate
    unless logged_in?
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

  def logged_in?
    !!current_user
  end
  
  def providers
    Authorization::PROVIDERS
  end

  helper_method :current_user, :current_user_with_auths, :logged_in?, :providers

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
end
