class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update]

	def index
		@events = Event.all
	end

	def show
	end

	def new
		@event = Event.new
	end

	def edit
	end

	def create
		@event = Event.create event_params

		if @event.save
			redirect_to event_path(@event)
		else
			render :new
		end
	end

	def update
		if @event.update event_params
			redirect_to @event
		else
			render :edit
		end
	end

	private
	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
		params.require(:event).permit(:name)
	end
end