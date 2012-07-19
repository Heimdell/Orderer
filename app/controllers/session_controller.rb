class SessionController < ApplicationController

  def new
      Rails.logger.debug "# Entering Session#new..."
      respond_to {|format| format.html}
  end

  def create
    Rails.logger.debug "# Entering Session#create..."
    user = User.find_by_email(params["session"]["email"])
    if user && user.authenticate(params["session"]["password"])
      Rails.logger.debug "# ... login successful."
      session[:user_id] = user.id
      redirect_to "/stories", :notice => "Logged in!"
    else
      Rails.logger.debug "# ... login failed. email:#{params["session"]["email"]}, password:#{params["session"]["password"]}."
      flash.now.alert = "Invalid email or password!"
      render "new"
    end
  end

  def destroy
#    session[:user_id] = nil
    user_sign_out

    redirect_to "/sign_in", :notice => "Logged out!"
  end
end
