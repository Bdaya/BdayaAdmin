class CourseGrade
  include Mongoid::Document
  field :grade, type: Integer

  belongs_to :course
end
