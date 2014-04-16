class EventAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.head? || user.vice_head? ||
    user.upper_board? || user.president?
  end

  def self.updatable_by?(user)
    user.head? || user.vice_head? ||
    user.upper_board? || user.president?
  end

  def self.deletable_by?(user)
    user.head? || user.vice_head? ||
    user.upper_board? || user.president?
  end

  def self.readable_by?(user)
    true
  end
end
