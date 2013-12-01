class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type, :type => String
	field :roomnumbbers, type => Array
	field :materials, type => Array
	field :notes, type => String
	field :permisiions, type => Hash
	field :status, type => String

  	belongs_to :event
  	belongs_to :meeting
  	belongs_to :creator, class_name: 'User', inverse_of: :created_requests
  	belongs_to :responsible_user, class_name: 'User', inverse_of: :requests_responsible_for
end
