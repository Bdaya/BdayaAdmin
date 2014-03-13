class EventsController < ApplicationController

	def new
		@event = Event.new
	end

  def requests
    @event=Event.find(params[:id])
    @materials_requests=@event.get_materials_requests
    @permissions_requests=@event.get_permissions_requests
    @request=Request.new
  end

  def new_materials
    @event = Event.find(params[:id])
    @request=Request.new(params[:request])
    @request.event = @event
    @request.request_type = "materials"
    if @request.save 
      redirect_to( requests_event_path(@event), notice: "Successfully created")
    else
      redirect_to :back, notice: "Error occured"
    end
  end

  def new_permissions
@event = Event.find(params[:id])
    @request=Request.new(params[:request])
    @request.event = @event
    @request.request_type = "permissions"
    if @request.save 
      redirect_to( requests_event_path(@event), notice: "Successfully created")
    else
      redirect_to :back, notice: "Error occured"
    end
   end 

	def create
		@event = Event.create!(params[:event])

    if @event.save
        redirect_to action:'index' , noitce: "Event Created succssfully"
    else
        render 'new'
    end
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
