class AuthenticationsController < ApplicationController
  before_filter :authenticate, :only => [:logout,:destroy]
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    
    if @auth # Log the authorizing user in.
      self.current_user = @auth.user
      redir = root_path
      if request.env['omniauth.origin']
        redir = request.env['omniauth.origin']
      end
      if redir.index(/posts\/\d/)
        redir += "#new-comment"
      end
      redirect_to redir, :notice => "Welcome, #{current_user.name}."
    else # redirect backwards, ask to try again unique save failed
      redirect_to((request.env['omniauth.origin'] || root_path),
        :notice => "Sorry, please try to connect again!")
    end
  end

  def logout
    session.delete('user_id')
    flash[:notice] = 'Thanks for viewing! Come back some time alright?'
    redirect_to root_path
  end
  
  def destroy
    auths = current_user.authorizations
    auth = auths.find_by_provider(params[:provider])
    redirect_to(:profile, :notice => "You aren't connected with that...") and return unless auth    
    if auths.length == 1 
      # then remove the user as well
      current_user.destroy
      session.delete('user_id')
      redirect_to root_path, :notice => "User account destroyed and unconnected!"
    else
      auth.destroy
      redirect_to :profile, :notice => "Successfully unconnected!"
    end
  end
  
  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
  
  protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end
end
