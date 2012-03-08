class UsersController < ApplicationController
  before_filter :authenticate

  # OPTIMIZE: could probably clean this up some
  def profile
    @user = current_user_with_auths
    @connected = @user.authorizations.collect{|a| a.provider}
    @to_connect = providers - @connected
    unless @user
      redirect_to root_path, :notice => "Sorry, try logging back in"
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    @connected = @user.authorizations.collect{|a| a.provider}
    @to_connect = providers - @connected
    unless @user && @user == current_user
      redirect_to root_path, :warn => "Weird, that's not who you are logged in as..."
    end
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html  { redirect_to profile_path,
                      :notice => 'Your profile was successfully updated!' }
        format.json  { render :json => {}, :status => :ok }
      else
        format.html  { render :action => profile_path }
        format.json  { render :json => @user.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
end
