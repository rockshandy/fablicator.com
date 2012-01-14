class AuthenticationsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    puts auth.to_json
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user
    redirect_to root_path, :notice => "Welcome, #{current_user.name}."
  end

  def logout
    session.delete('user_id')
    flash[:notice] = 'Thanks for viewing! Come back some time alright?'
    redirect_to root_path
  end

  def destroy
  end
end
