class Kid
  include Mongoid::Document
  field :name, type: String
  field :age, type: Integer

  has_and_belongs_to_many :courses
  has_many :course_grades
end
