class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

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
  
  field :name, :type => String
  field :phone, :type => String
  validates_length_of :phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :phone, :message=> "Must enter mobile number in numerical form only!"
  validates_uniqueness_of :phone, :message=> "This mobile number is already associated with another user!"

  field :major, :type => String
  field :faculty, :type => String
  field :semester, :type => Integer
  validates_numericality_of :semester, :message=> "Must enter semester in numerical form only!"

  field :tshirt_size, :type => String
  field :address, :type => String
  # field :progress, :type => Integer

  attr_accessible :semester, :phone, :name, :major, :faculty, :tshirt_size, :address

  has_and_belongs_to_many :courses
  has_many :teaching_sessions, class_name: 'Session', inverse_of: :tutor
  has_many :notifications
  has_many :newsFeedElements

  has_and_belongs_to_many :meetings_invited_to, class_name: 'Meeting', inverse_of: :invitees
  has_and_belongs_to_many :tasks

  has_many :created_requests, class_name: 'Request', inverse_of: :creator
  has_many :requests_responsible_for, class_name: 'Request', inverse_of: :responsible_user

  has_many :created_tasks, class_name: 'Task', inverse_of: :creator
  has_many :tasks_responsible_for, class_name: 'Task', inverse_of: :responsible_user
  has_many :evaluations

  belongs_to :head_of_committee, class_name: 'Committee', inverse_of: :head
  belongs_to :vice_of_committee, class_name: 'Committee', inverse_of: :vices
  belongs_to :member_of_committee, class_name: 'Committee', inverse_of: :members

  def get_pending_tasks
    tasks = self.tasks_responsible_for.where(:status=>"pending").to_a
  end

  def get_done_tasks
    tasks = self.tasks_responsible_for.where(:status=>"done").to_a
  end

  def get_sent_tasks
    tasks = self.created_tasks
  end

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

end
