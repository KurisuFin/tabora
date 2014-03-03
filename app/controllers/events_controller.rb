class EventsController < ApplicationController

	def index
		@events = Event.all
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.create params.require(:event).permit(:name)

		if @event.save
			redirect_to event_path(@event)
		else
			render :new
		end
	end
end