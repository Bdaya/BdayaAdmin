class CourseGrade
  include Mongoid::Document
  include Mongoid::Timestamps

  field :grade, type: Integer, :default => 0

  belongs_to :course
  belongs_to :kid
end