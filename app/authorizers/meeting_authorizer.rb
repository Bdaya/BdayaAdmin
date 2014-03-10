class MeetingAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.head?
  end

end