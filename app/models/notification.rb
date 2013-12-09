class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, :type => String
  field :seen, :type => Boolean

  belongs_to :creator, class_name: 'User', inverse_of: :created_notifications
  belongs_to :user

  
end
