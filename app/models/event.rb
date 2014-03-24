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
  field :tags, :type => String

  field :start_date, :type => Date
  field :start_time, :type => String
  field :end_date, :type => Date
  field :end_time, :type => String

  field :approved, :type => Boolean
  field :marketing_campaign, :type => Hash

  has_and_belongs_to_many :cases
  belongs_to :committee
  belongs_to :creator, class_name: 'User', inverse_of: :created_events
  belongs_to :project_manager, class_name: 'User', inverse_of: :managed_events
  has_and_belongs_to_many :members, class_name: 'User', inverse_of: :member_of_events
  has_many :requests
  has_many :event_images
  has_many :event_logs

  def profile_pic
    img = event_images.where(profile: true).first
  end

  def cover_pic
    img = event_images.where(cover: true).first
  end

  def get_materials_requests
    self.requests.where(request_type: 'materials').desc(:time).to_a
  end

  def get_permissions_requests
    self.requests.where(request_type: 'permissions').desc(:time).to_a
  end

end
