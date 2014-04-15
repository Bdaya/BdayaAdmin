class Meeting
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authority::Abilities

	field :time, :type => String
  field :date, :type => Date
	field :meeting_minuts, :type => String
  field :description, :type => String
  field :agenda, :type => String
  field :title, type: String
  #field :attendance, type: Array, default: [] 
    #Will be Entered as Array of 2D arrays in the form of [[Member,attendance_status],[Member,attendance_status],..]

  attr_accessor :logistics_notes

  self.authorizer_name = 'MeetingAuthorizer'

  has_and_belongs_to_many :attendees, class_name: "User", inverse_of: :attending_meetings
  has_many :attendances
  has_many :discussions
  belongs_to :creator, class_name: 'User', inverse_of: :created_meetings
	has_one :request



  validates_presence_of :time, :message=> "Cannot Be Blank"
  validates_presence_of :date, :message=> "Cannot Be Blank"
  validates_presence_of :description, :message=> "Cannot Be Blank"
  validates_presence_of :title, :message=> "Cannot Be Blank"
  validates_uniqueness_of :title, :message=> "Must Be Unique"

  def post_message(username, message)
    discussion  = Discussion.create(user_name:username, message:message)
    self.discussions << discussion
    self.save
  end
  
end 
