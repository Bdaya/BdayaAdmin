class Session
  include Mongoid::Document
  include Mongoid::Timestamps

	belongs_to :course
	has_one :request
	belongs_to :tutor , class_name: 'User', inverse_of: :teaching_sessions
end
