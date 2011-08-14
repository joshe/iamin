class EventsController < ApplicationController
  
  before_filter :confirm_logged_in
  
  def index
    @events = Event.all
    session[:return_to] ||= request.referer
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to event_path(@event.id)
    else
      render :action => "new"
    end
  end

  def show
    @id = params[:id]
    @event = Event.find(params[:id])
    @event_user_count = @event.users.size
    @event_cpp = @event.event_cost / @event_user_count
    @event_users = @event.users
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:message] = "Successfully updated"
      redirect_to event_path(@event.id)
    else
      flash[:message] = "Oops, didn't save successfully"
      render edit_event_path
    end
  end
  
  def join
    @event = Event.find(params[:id])
    @user = User.find(session[:user_id])
    unless !@event.users.find_by_id(@user.id).nil? 
      if @event.users << @user
        flash[:message] = "You have joined this event"
      else
        flash[:message] = "Oops. There was a problem joining this event."
      end
    else
      flash[:message] = "You've already joined this goal"
    end
    redirect_to event_path(@event.id)
  end
  
  def unjoin
    @event = Event.find(params[:id])
    @user = User.find(session[:user_id])
    if @event.users.delete(@user)
      flash[:message] = "You've been removed from this event."
    end
    redirect_to event_path(@event.id)
  end

end
