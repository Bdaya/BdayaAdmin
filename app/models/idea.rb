class Idea
  include Mongoid::Document
  field :rank , type: Integer
  field :title , type: String
  field :content , type: String
  field :no_of_upvotes, type: Integer
  

  belongs_to :member , class_name: 'User' , inverse_of: :ideas  
  
  
end
