class Meeting
  include Mongoid::Document
  include Mongoid::Timestamps

	field :time, :type => DateTime
	field :location, :type => String
	field :meeting_minuts, :type => String
	field :meeting_type, :type => String

  	has_one :creator, class_name: 'User', inverse_of: :created_meetings
  	has_and_belongs_to_many :invitees, class_name: 'User', inverse_of: :meetings_invited_to
  	has_one :request


  	def create_meeting(meeting,request)
  		f = Meeting.new
  		x = Request.new
  		f = meeting
  		x = request

  		if current_user
  			f.creator = current_user
  		end
  		x.time = f.time
  		x.creator = f.creator
  		x.request_type = "room"
  		x.save
  		f.save

  	end
end
