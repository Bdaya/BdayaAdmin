class Idea
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #field :rank , type: Integer
  field :title , type: String
  validates_presence_of :title, :message=> "must be included"
  field :content , type: String
  validates_presence_of :content, :message=> "must be included"
  #field :no_of_upvotes, type: Integer
  field :type , type: String

  belongs_to :user

end
