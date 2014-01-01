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

  has_many :created_notifications, class_name: 'Notification', inverse_of: :creator
  has_many :notifications, class_name: 'Notification', inverse_of: :receiver
  
  has_many :newsFeedElements

  has_and_belongs_to_many :meetings_invited_to, class_name: 'Meeting', inverse_of: :invitees
  has_and_belongs_to_many :tasks

  has_many :created_requests, class_name: 'Request', inverse_of: :creator
  has_many :requests_responsible_for, class_name: 'Request', inverse_of: :responsible_user

  has_many :created_tasks, class_name: 'Task', inverse_of: :creator
  has_many :tasks_responsible_for, class_name: 'Task', inverse_of: :responsible_user

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

end
