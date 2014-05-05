class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authority::Abilities

  #field :feedback, :type => String
  field :title, :type => String
  field :details, :type => String
  field :deadline, :type => Date
  field :status, :type => String, :default => "pending"
  field :type, :type => String
  field :seen_at, type: Time

  belongs_to :creator, class_name: 'User', inverse_of: :created_tasks
  belongs_to :responsible_user, class_name: 'User', inverse_of: :tasks_responsible_for
  has_many :discussions

  self.authorizer_name = 'TaskAuthorizer'

  validates_presence_of :deadline
  validates_presence_of :title
  validates_presence_of :type
  validates_presence_of :details

  def post_message(username, message)
    discussion  = Discussion.create(user_name:username, message:message)
    self.discussions << discussion
    self.save
  end

end
