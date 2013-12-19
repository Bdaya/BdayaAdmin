class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  field :request_type, :type => String
	field :roomnumber, :type => String
	field :materials, :type => Array
	field :notes, :type => String
	field :permissions, :type => Hash
	field :status, :type => String
  field :time, :type => DateTime

  	belongs_to :event
  	belongs_to :meeting
  	belongs_to :creator, class_name: 'User', inverse_of: :created_requests
  	belongs_to :responsible_user, class_name: 'User', inverse_of: :requests_responsible_for
end
