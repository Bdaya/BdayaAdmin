class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  #field :feedback, :type => String
  field :title, :type => String
  field :details, :type => String
  field :deadline, :type => Date
  field :status, :type => String
  field :type, :type => String

  belongs_to :creator, class_name: 'User', inverse_of: :created_tasks
  belongs_to :responsible_user, class_name: 'User', inverse_of: :tasks_responsible_for
  has_many :discussions

  validates_presence_of :deadline
  validates_presence_of :title
  validates_presence_of :type

  def post_message(username, message)
    discussion  = Discussion.create(user_name:username, message:message)
    self.discussions << discussion
    self.save
  end

end
