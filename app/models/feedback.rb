class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String

  belongs_to :user
  validates_presence_of :title, :message =>"must be included"
  validates_presence_of :content, :message =>"must be included"
  
end
