class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authority::UserAbilities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :invitable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time
  
  ## Invitable
  field :invitation_token, type: String
  field :invitation_created_at, type: Time
  field :invitation_sent_at, type: Time
  field :invitation_accepted_at, type: Time
  field :invitation_limit, type: Integer

  index( {invitation_token: 1}, {:background => true} )
  index( {invitation_by_id: 1}, {:background => true} )

  field :name, :type => String
  validates_presence_of :name, :message=> "Must enter your name!"

  field :phone, :type => String
  validates_presence_of :phone, :message=> "Must enter your Mobile number!"
  validates_length_of :phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :phone, :message=> "Must enter mobile number in numerical form only!"
  validates_uniqueness_of :phone, :message=> "This mobile number is already associated with another user!"

  field :major, :type => String
  #validates_presence_of :major, :message=> "Must enter your major!"

  field :faculty, :type => String
  validates_presence_of :faculty, :message=> "Must enter your faculty!"

  field :semester, :type => Integer
  validates_numericality_of :semester, :presence => true, :message=> "Must enter semester in numerical form only!"

  field :tshirt_size, :type => String
  validates_presence_of :tshirt_size, :message=> "Must enter your T-shirt Size!"

  field :address, :type => String
  validates_presence_of :address
  # field :progress, :type => Integer
  
  mount_uploader :image, ImageUploader
  attr_accessible :semester, :phone, :name, :major, :faculty, :tshirt_size, :address, :image, :image_cache

  has_and_belongs_to_many :courses
  has_many :teaching_sessions, class_name: 'Session', inverse_of: :tutor

  has_many :created_notifications, class_name: 'Notification', inverse_of: :creator
  has_many :notifications, class_name: 'Notification', inverse_of: :receiver
  
  has_many :newsFeedElements

  #has_and_belongs_to_many :meetings_invited_to, class_name: 'Meeting', inverse_of: :invitees
  has_and_belongs_to_many :attending_meetings, class_name: "Meeting", inverse_of: :attendees
  has_many :created_meetings, class_name: 'Meeting', inverse_of: :creator
  has_many :attendances

  has_and_belongs_to_many :tasks

  has_many :created_requests, class_name: 'Request', inverse_of: :creator
  has_many :requests_responsible_for, class_name: 'Request', inverse_of: :responsible_user

  has_many :created_tasks, class_name: 'Task', inverse_of: :creator
  has_many :tasks_responsible_for, class_name: 'Task', inverse_of: :responsible_user
  has_many :evaluations

  has_one :head_of_committee, class_name: 'Committee', inverse_of: :head
  belongs_to :vice_of_committee, class_name: 'Committee', inverse_of: :vices
  belongs_to :member_of_committee, class_name: 'Committee', inverse_of: :members
  field :president, :type => Boolean
  field :upper_board, :type => Boolean
  has_many :managed_events, class_name: 'Event', inverse_of: :project_manager
  has_and_belongs_to_many :member_of_events, class_name: 'Event', inverse_of: :members
  has_many :created_events, class_name: 'Event', inverse_of: :creator
  has_many :created_logs, class_name: 'EventLog', inverse_of: :creator


  has_many :feedbacks

  has_many :created_ideas, class_name: 'Idea', inverse_of: :creator
  has_and_belongs_to_many :upvoted_ideas, class_name: 'Idea', inverse_of: :upvoters
  
  def get_pending_tasks
    tasks = self.tasks_responsible_for.where(status: "pending").to_a
  end

  # def get_done_tasks
  #   tasks = self.tasks_responsible_for.where(:status=>"done").to_a
  # end

  def get_today_tasks
    self.tasks_responsible_for.where(:deadline => DateTime.now.to_date).asc(:deadline)
  end

  def get_tomorrow_tasks
    self.tasks_responsible_for.where(:deadline => DateTime.now.tomorrow.to_date).asc(:deadline)
  end

  def get_week_tasks
    tasks = []
    self.tasks_responsible_for.asc(:deadline).each do |t|
      if(t.deadline != DateTime.now.to_date && t.deadline != DateTime.now.tomorrow.to_date && t.deadline > DateTime.now.tomorrow.to_date && t.deadline <= DateTime.now.end_of_week.to_date - 2)
        tasks << t
      end
    end
    return tasks
  end

  def get_later_tasks
    tasks = []
    self.tasks_responsible_for.asc(:deadline).each do |t|
      if(t.deadline != DateTime.now.to_date && t.deadline != DateTime.now.tomorrow.to_date && t.deadline > DateTime.now.end_of_week.to_date - 2)
        tasks << t
      end
    end
    return tasks
  end

  def get_past_tasks
    tasks = []
    self.tasks_responsible_for.asc(:deadline).each do |t|
      if(t.deadline < DateTime.now.to_date)
        tasks << t
      end
    end
    return tasks
  end

  def get_today_sent_tasks
    self.created_tasks.where(:deadline => DateTime.now.to_date).asc(:deadline)
  end

  def get_tomorrow_sent_tasks
    self.created_tasks.where(:deadline => DateTime.now.tomorrow.to_date).asc(:deadline)
  end

  def get_week_sent_tasks
    tasks = []
    self.created_tasks.asc(:deadline).each do |t|
      if(t.deadline != DateTime.now.to_date && t.deadline != DateTime.now.tomorrow.to_date && t.deadline > DateTime.now.tomorrow.to_date && t.deadline <= DateTime.now.end_of_week.to_date - 2)
        tasks << t
      end
    end
    return tasks
  end

  def get_later_sent_tasks
    tasks = []
    self.created_tasks.asc(:deadline).each do |t|
      if(t.deadline != DateTime.now.to_date && t.deadline != DateTime.now.tomorrow.to_date && t.deadline > DateTime.now.end_of_week.to_date - 2)
        tasks << t
      end
    end
    return tasks
  end

  def get_past_sent_tasks
    tasks = []
    self.created_tasks.desc(:deadline).each do |t|
      if(t.deadline < DateTime.now.to_date)
        tasks << t
      end
    end
    return tasks
  end
  # def get_sent_tasks
  #   tasks = self.created_tasks
  # end

  def assign_task(member,deadline,title,details)
    t = Task.new
    t.creator = self
    t.responsible_user = member
    t.title = title
    t.details = details
    t.deadline = deadline
    t.status = "pending"
    t.save
  end

  def mark_task_done(t)
    t.status = "done"
    t.save
  end

  def reopen_task(t)
    t.status = "pending"
    t.save
  end

  def accept_task(t)
    t.status = "accepted"
    t.save
  end


  def get_crit
    data = []
    categories = []

    crit1_data = []
    crit2_data = []
    crit3_data = []
    crit4_data = []
    crit5_data = []

    evaluations.each do |ev|
      crit1_data << ev.cri1
      crit2_data << ev.cri2
      crit3_data << ev.cri3
      crit4_data << ev.cri4
      crit5_data << ev.cri5

      categories << ev.created_at.to_date.to_formatted_s(:short)
    end
    data << crit1_data
    data << crit2_data
    data << crit3_data
    data << crit4_data
    data << crit5_data
    [data,{categories: categories}]
  end

  def get_today_meetings
    invited_meetings = self.attending_meetings.where(:date => DateTime.now.to_date).to_a
    created_meetings = self.created_meetings.where(:date => DateTime.now.to_date).to_a
    meetings = invited_meetings.concat(created_meetings)
  end

  def get_tomorrow_meetings
    invited_meetings = self.attending_meetings.where(:date => DateTime.now.tomorrow.to_date).to_a
    created_meetings = self.created_meetings.where(:date => DateTime.now.tomorrow.to_date).to_a
    meetings = invited_meetings.concat(created_meetings)
  end

  def get_week_meetings
    meetings = []
    self.attending_meetings.each do |m|
      if (m.date != DateTime.now.to_date && m.date != DateTime.now.tomorrow.to_date && m.date > DateTime.now.tomorrow.to_date && m.date <= DateTime.now.end_of_week.to_date - 2)
        meetings << m
      end
    end  

    self.created_meetings.each do |m|
      if (m.date != DateTime.now.to_date && m.date != DateTime.now.tomorrow.to_date && m.date > DateTime.now.tomorrow.to_date && m.date <= DateTime.now.end_of_week.to_date - 2)
        meetings << m
      end
    end
    meetings.sort! { |a,b| a.date <=> b.date }
    return meetings
  end

  def get_later_meetings
    meetings = []
    self.attending_meetings.each do |m|
      if (m.date != DateTime.now.to_date && m.date != DateTime.now.tomorrow.to_date && m.date > DateTime.now.end_of_week.to_date - 2)
        meetings << m
      end
    end  

    self.created_meetings.each do |m|
      if (m.date != DateTime.now.to_date && m.date != DateTime.now.tomorrow.to_date && m.date > DateTime.now.end_of_week.to_date - 2)
        meetings << m
      end
    end
    meetings.sort! { |a,b| a.date <=> b.date }
    return meetings
  end

  def get_past_meetings
    meetings = []
    self.attending_meetings.each do |m|
      if (m.date < DateTime.now.to_date)
        meetings << m
      end
    end  

    self.created_meetings.each do |m|
      if (m.date < DateTime.now.to_date)
        meetings << m
      end
    end
    meetings.sort! { |a,b| b.date <=> a.date }
    return meetings
  end
p
  def head?
    head_of_committee != nil
  end

  def vice_head?
    vice_of_committee != nil
  end

  def upper_board?
    return upper_board == true
  end

  def president?
    return president == true
  end

  def in_committee?(com_name)
    return member_of_committee.name == com_name if member_of_committee
  end  

  def is_meeting_attendance(m,s)
    a = self.attendances.where(:meeting_id => m.id).first
    return a.status == s
  end

  def has_meeting_attendance(m)
   return self.attendances.where(:meeting_id => m.id).count > 0
  end
 
  def set_meeting_attendance(m,s)
    a = self.attendances.where(:meeting_id => m.id).first
    a.status = s
    a.save
  end

  def is_brens?
    president? || upper_board?
  end

end
