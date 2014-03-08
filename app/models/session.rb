class Session
  include Mongoid::Document
  include Mongoid::Timestamps

	belongs_to :course , class_name: 'Course' , inverse_of: :sessions
	
	belongs_to :tutor , class_name: 'User', inverse_of: :teaching_sessions
end
