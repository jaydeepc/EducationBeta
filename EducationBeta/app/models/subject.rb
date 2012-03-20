class Subject < ActiveRecord::Base
  attr_accessible :subject

  has_many :question
 end
