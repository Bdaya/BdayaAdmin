class EventsController < ApplicationController

	def new
		@event = Event.new
	end

	def create
		Event.create!(params[:event])
		redirect_to action: "index"
	end

	def index
		@events = Event.all.to_a
	end

	def delete
		
	end

	def update
		
	end

end
