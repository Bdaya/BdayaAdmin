class Spreadsheet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :committee
end
