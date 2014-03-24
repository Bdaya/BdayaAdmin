class Attendance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, :type => String #attended | excused | absent

  belongs_to :meeting
  belongs_to :user

  def self.create_attendance(m,u)
  	a = Attendance.create!()
  	m.attendances << a
  	u.attendances << a
  end

end