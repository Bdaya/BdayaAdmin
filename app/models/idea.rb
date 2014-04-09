class Idea
  include Mongoid::Document
  field :rank , type: Integer
  field :title , type: String
  validates_presence_of :title, :message=> "must be determined"
  field :content , type: String
  validates_presence_of :content, :message=> "must be determined"
  field :no_of_upvotes, type: Integer
  field :type , type: String

  belongs_to :member , class_name: 'User' , inverse_of: :ideas  
  
  
end
