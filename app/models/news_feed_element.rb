class NewsFeedElement
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, :type => String


end
