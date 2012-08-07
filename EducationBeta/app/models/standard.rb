class Standard < ActiveRecord::Base
  attr_accessible :name
  
  has_many :uploads
end
