class Upload < ActiveRecord::Base
  attr_accessor :document
  has_attached_file :document

  belongs_to :user

  validate :check_content_presence
  validate :check_content_size

  def check_content_presence
    if self.document_file_name.nil?
      self.errors.add(:base, "Please select a file to upload")
      return false
    end
    return true
  end

  def check_content_size
    return false if self.document_file_size.nil? 
    if self.document_file_size > 5.megabytes
      self.errors.add(:base, "There upload size cannot exceed 5 MB")
      return false
    end
    return true
  end
   
  def belongs_to? user
    return false unless self.user_id == user.id
    return true
  end
end
