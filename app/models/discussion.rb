class Discussion
  include Mongoid::Document

  field :user_name
  field :message

  validates_presence_of :user_name, :message=> "Must enter a user name"
  validates_presence_of :message, :message=> "Must enter a message"

  belongs_to :meeting, class_name: 'Meeting'
  belongs_to :task
  belongs_to :idea
  
end
