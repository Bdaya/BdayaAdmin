class CourseGrade
  include Mongoid::Document
  include Mongoid::Timestamps

  field :grade, type: Integer

  belongs_to :course
  belongs_to :kid
end
