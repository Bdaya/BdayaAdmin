class MeetingsController < ApplicationController
  
  def index
    @meetings = Meeting.desc(:date).all.to_a
  end

  def show
     @meeting = Meeting.find(params[:id])
     @request = Request.find_by(meeting_id: @meeting.id)
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def new
    @meeting = Meeting.new
    @request = Request.new
  end

  def create
    params[:meeting][:attendee_ids].shift
    @meeting = Meeting.new(params[:meeting])    
    @meeting.creator = current_user
    begin
      Time.parse(@meeting.time)
    rescue Exception
      @meeting.time = "12:00pm" #default time
    end
    @request = Request.new
    @request.notes = params[:notes]
    @request.creator = @meeting.creator
    @request.meeting = @meeting
    @request.time = @meeting.date
    @request.request_type = "room"
    @request.roomnumber = @meeting.location

    if (@meeting.save && @request.save)
      redirect_to action: 'index'
    else
      @meeting.destroy
      @request.destroy
      render action: "index" 
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    @request = @meeting.request
    @request.notes = params[:notes]
    @request.time = params[:meeting][:date]
    @request.request_type = "room"

    @meeting.attendees.each do |attender|
      param_att = "attendance_"+attender.id
      if(params[param_att])
        @meeting.attendance << [attender.id,params[param_att]]
      end
    end

    if (@meeting.update_attributes(params[:meeting]) && @request.save)
      redirect_to action: 'index', notice: 'Meeting was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @request = @meeting.request
    if @meeting.destroy && @request.destroy
      redirect_to meetings_path
    end
  end
end

private #---------------------------------------------------------------------------------



