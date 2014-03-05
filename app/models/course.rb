class Course
  include Mongoid::Document
  field :name, type: String
  
  has_many :sessions
  has_and_belongs_to_many :kids
  has_many :course_grades
end
