class EventImage
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader
  field :profile, :type => Boolean, :default => false
  field :cover, :type => Boolean, :default => false
  belongs_to :event
end
