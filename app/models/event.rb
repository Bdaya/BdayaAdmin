class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :description, :type => String
  field :idea, :type => String
  field :theme, :type => String
  field :slogan, :type => String
  field :location, :type => String
  field :fb_url, :type => String

  field :start_date, :type => Date
  field :start_time, :type => String
  field :end_date, :type => Date
  field :end_time, :type => String

  field :approved, :type => Boolean
  field :marketing_campaign, :type => Hash

  has_and_belongs_to_many :cases
  belongs_to :committee
  has_one :creator, class_name: 'User', inverse_of: :created_events
  has_one :project_manager, class_name: 'User', inverse_of: :managed_events
  has_and_belongs_to_many :members, class_name: 'User', inverse_of: :member_of_events
  has_many :requests
  has_many :event_images

  def profile_pic
    event_images.where(:profile => true).first
  end

  def cover_pic
    event_images.where(:cover => true).first
  end
end
