class SessionController < ApplicationController
  def new
      respond_to {|format| format.html}
  end

  def create
    user = User.find_by_email(params["session"]["email"])
    if user && user.authenticate(params["session"]["password"])
      session[:user_id] = user.id
      redirect_to "/stories", :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password!"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
