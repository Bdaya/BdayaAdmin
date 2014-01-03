class Evaluation
  include Mongoid::Document
  include Mongoid::Timestamps


  attr_accessible :user_id

  field :cri1, :type => Integer 
  field :cri2, :type => Integer 
  field :cri3, :type => Integer 
  field :cri4, :type => Integer 
  field :cri5, :type => Integer

  belongs_to :user
end
