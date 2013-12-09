class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :sessions
end
