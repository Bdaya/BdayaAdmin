class EventsController < ApplicationController

  authorize_actions_for Event

	def new
		@event = Event.new
    @project_managers = User.all
	end

	def create
		@event = Event.new(params[:event])

    if @event.save
        redirect_to events_path , notice: "Event Created succssfully"
    else
      redirect_to events_path, alert: @event.errors.full_messages.join("\n")
    end

	end

	def index
		@events = Event.all.to_a
	end

  def show
    @event = Event.find(params[:id])
    @materials_requests=@event.get_materials_requests
    @permissions_requests=@event.get_permissions_requests
    @request = Request.new
  end

	def delete
		
	end

	def update
		@event = Event.find(params[:id])
    @event.update_attributes(params[:event])
    redirect_to @event
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
      redirect_to(event_path(@event), notice: "Successfully created")
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
      redirect_to(event_path(@event), notice: "Successfully created")
    else
      redirect_to :back, notice: "Error occured"
    end
   end 


  def profile_picture
    event = Event.find(params[:id])
    image = EventImage.find(params[:image_id])
    if(event.profile_pic!=image)
      EventImage.where(event: event).update_all(profile: false)
      image.update_attribute(:profile, true)
      redirect_to event, :notice => "Successfully made the Image the profile picture."
    else
      redirect_to event, :notice => "This Image is already the profile picture."
    end
  end

  def cover_picture
    event = Event.find(params[:id])
    image = EventImage.find(params[:image_id])
    if(event.cover_pic!=image)
      EventImage.where(event:event).update_all(cover: false)
      image.update_attribute(:cover, true)
      redirect_to event, :notice => "Successfully made the Image the Cover picture."
    else
      redirect_to event, :notice => "This Image is already the Cover picture."
    end
  end

  def add_image
    event = Event.find(params[:id])
    EventImage.create(:image => params[:event][:image], :event => event)
    redirect_to event, :notice => "Successfully Added Image."
  end

  def rate_image
    event = Event.find(params[:id])
    image = EventImage.find(params[:image_id])
    image.raters = image.raters+1
    image.rating = ((image.rating+(params[:rating].to_i))/image.raters).round(1)
    image.save
    redirect_to event, :notice => "Successfully Rated Image."
  end

end
