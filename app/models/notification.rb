class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, :type => String
  field :seen, :type => Boolean
  field :url, :type => String
  field :type, :type => String

=begin	
The type of a notification can be one of the following :
	- Event, Announcment, Meeting, etc.
	Author : 3obad
=end

  belongs_to :creator, class_name: 'User', inverse_of: :created_notifications
  belongs_to :receiver, class_name: 'User', inverse_of: :notifications

  def seen
  	self.seen = true;
  	self.save
  end

=begin
	The following method takes as an input, the creator, a list of the destination users,
	the type of the notification, and the url that the user will be redirected to when
	clicking on the notification.
=end

  def self.notify(creator, destination, type, url)
  	destination.each do |d|
  		n = Notification.new
  		n.creator = creator
  		n.receiver = d
  		n.type = type
  		n.description = "#{creator.name} is notifying you about something"
  		n.url = url
  		n.save!
  	end
  end

  
end
