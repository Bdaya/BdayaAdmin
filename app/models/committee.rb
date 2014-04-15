class Committee
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  belongs_to :head, class_name: 'User', inverse_of: :head_of_committee
  has_many :vices, class_name: 'User', inverse_of: :vice_of_committee
  has_many :members, class_name: 'User', inverse_of: :member_of_committee
  has_many :events
  has_many :spreadsheets

end
