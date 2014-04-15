class MeetingsController < ApplicationController

  authorize_actions_for Meeting

  def index
    #if Rails.cache.read("ERROR").nil?
      @ERROR = []
      #Rails.cache.write("ERROR","[]")
    #else
      #@ERROR = Rails.cache.read("ERROR")
    #end
    @meetings = Meeting.desc(:date).all.to_a
    @today_meetings = current_user.get_today_meetings
    @tomorrow_meetings = current_user.get_tomorrow_meetings
    @week_meetings = current_user.get_week_meetings
    @later_meetings = current_user.get_later_meetings
    @past_meetings = current_user.get_past_meetings
    # The creation of a new model is in index view (inside the modal)
    @meeting = Meeting.new
    @request = Request.new
  end

  def show
     @meeting = Meeting.find(params[:id])
     @request = Request.find_by(meeting_id: @meeting.id)

     # Show Page is rendered in details partial
     render :partial => 'details'
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def new
    @meeting = Meeting.new
    @request = Request.new
  end

  def create
    #Causing error, no need for invites in creation a new meeting.
    # params[:meeting][:attendee_ids].shift
    @meeting = Meeting.new(params[:meeting])    
    @meeting.creator = current_user
    begin
      Time.parse(@meeting.time)
    rescue Exception
      @meeting.time = "12:00pm" #default time
    end
    @request = Request.new
    @request.notes = params[:meeting][:logistics_notes]
    @request.creator = @meeting.creator
    @request.meeting = @meeting
    @request.time = @meeting.time
    @request.date = @meeting.date
    @request.request_type = "room"

    if (@meeting.save && @request.save)
        @meeting.attendees.each do |a|
          Attendance.create_attendance(@meeting,a)   
    end
      redirect_to meetings_path
    else
      @ERROR = []
      @meeting.errors.full_messages.each do |msg|
        @ERROR << msg
      end      
      #Rails.cache.write("ERROR", @ERROR)
      @meeting.destroy
      @request.destroy
      redirect_to meetings_path, alert: @meeting.errors.full_messages.join("\n")
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    @request = @meeting.request
    @request.notes = params[:meeting][:logistics_notes]
    @request.time = params[:meeting][:date]
    @request.request_type = "room"

    @meeting.attendees.each do |attender|
      param_att = "attendance_"+attender.id
      if(params[param_att])
        @meeting.attendance << [attender.id,params[param_att]]
      end
    end

    if (@meeting.update_attributes(params[:meeting]) && @request.save)
      @meeting.attendees.each do |a|
        if(!a.has_meeting_attendance(@meeting))
          Attendance.create_attendance(@meeting,a)
        end   
      end
      redirect_to action: 'index', notice: 'Meeting was successfully updated.'
    else
      redirect_to meetings_path, alert: @meeting.errors.full_messages.join("\n")
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @request = @meeting.request
    if @meeting.destroy && @request.destroy
      redirect_to meetings_path
    end
  end

  def set_attendance
  @user = User.find(params[:user_id])
  @meeting = Meeting.find(params[:id])
  @user.set_meeting_attendance(@meeting,params[:attendance_status])
  redirect_to meetings_path
  end

  def send_message
    @meeting = Meeting.find(params[:id])
    @user = current_user.name
    @message = params[:message]
    @meeting.post_message(@user,@message)
    redirect_to meetings_path
  end

end
