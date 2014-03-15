class EventLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, :type => String
  belongs_to :event
  belongs_to :event_image
  belongs_to :creator, class_name: 'User', inverse_of: :created_log
  field :type, :type => String

  def self.add(type,e,i,c,old,newer)
    if(type=='changed_description')
      content = "Description has been changed."
      EventLog.create(content: content, event: e, creator: c, type: 'cd')
    elsif(type == 'defined_description')
      content = "Description has been added."
      EventLog.create(content: content, event: e, creator: c, type: 'dd')
    elsif(type == 'changed_title')
      content = "Title has been changed."
      EventLog.create(content: content, event: e, creator: c, type: 'ct')
    elsif(type == 'defined_title')
      content = "Title has been added."
      EventLog.create(content: content, event: e, creator: c, type: 'dt')
    elsif(type == 'added_image')
      content = "Image has been added to Designs."
      EventLog.create(content: content, event: e, creator: c, event_image: i, type: 'ai')
    elsif(type == 'changed_profile_pic')
      content = "New profile Picture has been defined."
      EventLog.create(content: content, event: e, creator: c, type: 'cpp')
    elsif(type == 'changed_cover_pic')
      content = "New cover Picture has been defined."
      EventLog.create(content: content, event: e, creator: c, type: 'ccp')
    elsif(type == 'changed_idea')
      content = "Idea has been changed."
      EventLog.create(content: content, event: e, creator: c, type: 'ci')
    elsif(type == 'defined_idea')
      content = "Idea has been defined."
      EventLog.create(content: content, event: e, creator: c, type: 'di')
    elsif(type == 'changed_theme')
      content = "Theme has been changed."
      EventLog.create(content: content, event: e, creator: c, type: 'ct')
    elsif(type == 'defined_theme')
      content = "Theme has been defined."
      EventLog.create(content: content, event: e, creator: c, type: 'dt')
    elsif(type == 'added_members')
      content = "New member has been added."
      EventLog.create(content: content, event: e, creator: c, type: 'am')
    elsif(type == 'defined_location')
      content = "Location has been defined."
      EventLog.create(content: content, event: e, creator: c, type: 'dl')
    elsif(type == 'changed_location')
      content = "Location has been changed."
      EventLog.create(content: content, event: e, creator: c, type: 'cl')
    elsif(type == 'request_material')
      content = "New Material has been requested."
      EventLog.create(content: content, event: e, creator: c, type: 'rm')
    end
  end
end
