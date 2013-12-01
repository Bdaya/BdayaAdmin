class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :description, :type => String
  field :general_info, :type => String
  field :booth_desgin, :type => String
  field :poster, :type => String
  field :teaser, :type => String

  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :approved, :type => Boolean
  field :marketing_campaign, :type => Hash

  has_and_belongs_to_many :cases
  belongs_to :committee
  has_one :project_manager, class_name: 'User', inverse_of: :managed_events
  has_many :members, class_name: 'User', inverse_of: :members_of_events
  has_many :requests

end
