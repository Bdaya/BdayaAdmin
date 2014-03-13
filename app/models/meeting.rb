class Meeting
  include Mongoid::Document
  include Mongoid::Timestamps

	field :time, :type => String
  field :date, :type => Date
	field :location, :type => String
	field :meeting_minuts, :type => String
	# field :meeting_type, :type => String #*************No need for meeting type
  field :description, :type => String
  field :agenda, :type => String

	belongs_to :creator, class_name: 'User', inverse_of: :created_meetings
	#has_and_belongs_to_many :invitees, class_name: 'User', inverse_of: :meetings_invited_to
	has_one :request


  field :title, type: String

  # field :meeting_minutes1, type: String
  # field :meeting_minutes2, type: String
  # field :meeting_minutes3, type: String
  # field :room, type: String
  field :attendance, type: Array, default: [] #Will be Entered as Array of 2D arrays in the form of [[Member,attendance_status],[Member,attendance_status],..]
  # field :meeting_time, type: DateTime

  # belongs_to :creator, class_name: "Member", inverse_of: :created_meetings
  has_and_belongs_to_many :attendees, class_name: "User", inverse_of: :attending_meetings
  # has_one :request

  has_many :attendances
  has_many :chat, class_name: "Discussion"

  def post_message(username, message)
    discussion  = Discussion.create(user_name:username, message:message)
    self.chat << discussion
    self.save!
  end

  def get_messages
    return self.chat
  end

  def test
    return self.chat.to_a[0].user_name
  end

end 
