class MeetingAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.head? || user.vice_head? ||
    user.upper_board? || user.president?
  end

  def self.readable_by?(user)
    true
  end
end