class FilterStoriesController < ApplicationController
  def index
    @state = params[:state]
    @user  = params[:user]

    @stories =
      case [@state.nil?, @user.nil?]
        when [true, true] then
          Story.all
        when [true, false] then 
          Story.where :user_id => params[:user]
        when [false, true] then
          Story.where :state => params[:state]
        else
          Story.where :state => params[:state], :user_id => params[:user]
      end

    respond_to do |format|
      format.html
      format.json { render :json => @stories }
    end
  end
end
