class EventsController < ApplicationController
  
  def index
    @events = Event.all
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
    @event_cpp = @event.event_cost / 6
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

end
