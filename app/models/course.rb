class Course
  include Mongoid::Document
  field :name, type: String
  
  has_many :sessions , class_name: 'Session' , inverse_of: :course
  has_and_belongs_to_many :kids
  has_many :course_grades
  has_and_belongs_to_many :tutors, class_name: 'User', inverse_of: :courses
end
