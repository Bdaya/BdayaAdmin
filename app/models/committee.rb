class Committee
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String

  has_one :head, class_name: 'User', inverse_of: :head_of_committee
  has_many :vices, class_name: 'User', inverse_of: :vice_of_committee
  has_many :members, class_name: 'User', inverse_of: :member_of_committee
  has_many :events
  has_many :Spreadsheets
  
  validates_presence_of :head, :message=> "Must choose a head!"
end
