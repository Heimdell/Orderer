class StoriesController < ApplicationController

  before_filter :basic_auth, :only => [:state, :edit, :delete, :new, :create, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.scoped

    @stories = @stories.where(:user_id => params[:user])  if params[:user].present?  
    @stories = @stories.where(:state => params[:state]) if params[:state].present?  

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @stories.all }
    end
  end
  
  # GET /stories/1/state
  def state
    @story = Story.find(params[:id])
    @state = params[:state].to_sym
    
    @story.available_transitions.each do |action, _|
      Rails.logger.debug @state
    end
    
    if @story.available_transitions[@state]

      @story.worker = current_user if @state == :start
      @story.send(@state)
      @story.save
      
      render :action => "show"
    else
      redirect_to "/422.html"
    end
  end
  
  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.json
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, :notice => 'Story was successfully created.' }
        format.json { render :json => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.json { render :json => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.json
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to @story, :notice => 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :no_content }
    end
  end
end
