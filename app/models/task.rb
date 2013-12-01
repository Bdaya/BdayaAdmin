class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :feedback, :type => String
  field :title, :type => String
  field :details, :type => String
  field :deadline, :type => DateTime
  field :status, :type => String
  belongs_to :creator, class_name: 'User', inverse_of: :created_tasks
  belongs_to :responsible_user, class_name: 'User', inverse_of: :tasks_responsible_for



end
