class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :email, :type => String
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

  has_and_belongs_to_many :courses
  has_many :notifications
  has_many :newsFeedElements
  has_and_belongs_to_many :meetings
  has_and_belongs_to_many :tasks
  has_many :created_requests, class_name: 'Request', inverse_of: :creator
  has_many :requests_responsible_for, class_name: 'Request', inverse_of: :responsible_user

  has_many :created_tasks, class_name: 'Task', inverse_of: :creator
  has_many :tasks_responsible_for, class_name: 'Task', inverse_of: :responsible_user

  belongs_to :head_of_committee, class_name: 'Committee', inverse_of: :head
  belongs_to :vice_of_committee, class_name: 'Committee', inverse_of: :vices
  belongs_to :member_of_committee, class_name: 'Committee', inverse_of: :members


end
