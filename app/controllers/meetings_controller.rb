class MeetingsController < ApplicationController
  
  def index
    @meeting = Meeting.desc(:time).all.to_a
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
    @meeting = Meeting.new(params[:meeting])    
    @request = Request.new(params[:meeting][:@request])
    @meeting.creator = current_user
    @request.creator = @meeting.creator
    @request.meeting = @meeting
    @request.time = @meeting.time
    @request.request_type = "room"

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
    @request = Request.find(params[:id])
    if @meeting.update_attributes(params[:meeting]) && @request.update_attributes(params[:meeting][:@request])
      redirect_to action: 'index', notice: 'Metesing was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @request = Request.find_by(meeting_id: @meeting.id)
    if @meeting.destroy && @request.destroy
      redirect_to action: 'index'
    end
  end
end


private #---------------------------------------------------------------------------------



