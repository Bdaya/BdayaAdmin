class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String

  belongs_to :user
  validates_presence_of :title, :message =>"Must include a title"
  validates_presence_of :content, :message =>"Must include a content"
  
end
