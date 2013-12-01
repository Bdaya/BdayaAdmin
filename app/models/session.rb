class Session
  include Mongoid::Document
  include Mongoid::Timestamps

	has one course
	has one request
	has one courses
	has one tutor (user)
end
