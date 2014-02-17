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

  def show
    @event = Event.find(params[:id])
  end

	def delete
		
	end

	def update
		
	end

  def profile_picture
    event = Event.find(params[:id])
    image = EventImage.find(params[:image_id])
    EventImage.all.each do |img|
    	img.profile = false
    	img.save
    end
    image.profile = true
   	image.save
    redirect_to event, :notice => "Successfully made the Image the profile picture."
  end

  def cover_picture
    event = Event.find(params[:id])
    image = EventImage.find(params[:image_id])
    EventImage.all.each do |img|
    	img.cover = false
    	img.save
    end
    image.cover = true
   	image.save
    redirect_to event, :notice => "Successfully made the Image the Cover picture."
  end

  def add_image
    event = Event.find(params[:id])
    EventImage.create(:image => params[:event][:image], :event => event)
    redirect_to event, :notice => "Successfully Added Image."
  end

end
