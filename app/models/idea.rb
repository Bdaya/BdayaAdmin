class Idea
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #field :rank , type: Integer
  field :title , type: String
  validates_presence_of :title, :message=> "must be included"
  field :content , type: String
  validates_presence_of :content, :message=> "must be included"
  field :upvotes, type: Integer
  field :type , type: String

  belongs_to :creator, class_name: 'User', inverse_of: :created_ideas
  has_and_belongs_to_many :upvoters, class_name: 'User', inverse_of: :upvoted_ideas
  has_many :discussions

  def post_message(username, message)
    discussion  = Discussion.create(user_name:username, message:message)
    self.discussions << discussion
    self.save
  end
  
end
