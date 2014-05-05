class EventImage
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader
  field :profile, :type => Boolean, :default => false
  field :cover, :type => Boolean, :default => false
  field :rating, :type => Float, :default => 0.0
  field :ratings, :type => Array, :default => []
  field :raters, :type => Integer, :default => 0
  belongs_to :event
  has_many :event_logs

  has_and_belongs_to_many :voters, class_name: 'User', inverse_of: :voted_images
end
