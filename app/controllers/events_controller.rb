class EventsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :populate_max, :only => [:new, :edit]
  
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
    @user = User.find(session[:user_id])
    @user_is_in = @event_users.include?(@user)
    
    if @event.max <= @event_user_count and @event.max != 0
      @event_status = :hitMax
    elsif @event.threshold > @event_user_count
      @event_status = :nogo
      @event_users_remaining = @event.threshold - @event_user_count
      @event_users_remaining = (@event_users_remaining == 1) ? "#{@event_users_remaining} person" : "#{@event_users_remaining} people"
    else
      @event_status = :go
    end
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
  
  def populate_max
    @max = Array.new
    (0..150).each do |m| 
      if m == 0
        @max << ["No max", 0]
      else
        @max << [m, m]
      end
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
