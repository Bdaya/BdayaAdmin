class MeetingAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.head?
  end

  def self.readable_by?(user)
    true
  end

end