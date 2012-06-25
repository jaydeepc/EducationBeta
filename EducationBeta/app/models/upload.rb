class Upload < ActiveRecord::Base
  attr_accessor :document
  has_attached_file :document

  belongs_to :user
end
