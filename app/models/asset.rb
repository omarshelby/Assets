class Asset < ActiveRecord::Base

  validates_presence_of :Purchase_Order_Number, :Request_Number, :Order_Date, :Location, :Description
  validates_uniqueness_of :Purchase_Order_Number, :message => 'already exists'
  validates_uniqueness_of :Request_Number, :message => 'already exists'
  attr_accessible :Purchase_Order_Number, :Request_Number, :Order_Date, :Location, :Description

  cattr_reader :per_page
  @@per_page = 5

end
