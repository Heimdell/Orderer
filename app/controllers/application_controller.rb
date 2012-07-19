class ApplicationController < ActionController::Base
  include AuthHelper

#  before_filter :basic_auth

  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  helper_method :current_user
end
