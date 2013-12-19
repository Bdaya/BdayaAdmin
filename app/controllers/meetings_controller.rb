class MeetingsController < ApplicationController
  def index
    @meeting = Meeting.all
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
    @request.meeting = @meeting
    @request.request_type = "room"

    if @meeting.save &&  @request.save
      redirect_to action: 'index', notice: 'Meeting was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    @request =  update_request
    if @meeting.update_attributes(params[:meeting]) and @request.save
      redirect_to action: 'index', notice: 'Metesing was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
      redirect_to action: 'index'
  end
end


private #---------------------------------------------------------------------------------

def update_request 
  @request = Request.find(params[:id])
  @request.destroy
  @request.new(params[:request])
  @request
end


