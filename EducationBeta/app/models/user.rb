class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :type, :status, :validation_uuid, :password_confirmation
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates_presence_of :name
  validates_presence_of :status
  validates_presence_of :validation_uuid
  validates :type, :presence => true, :inclusion => {:in => %w(Tutor Student)}

  has_many :uploads

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.authenticate(password) && user.status == 'registered'
      user
    else
      nil
    end
  end

  def is_tutor?
    true ? self.type == "Tutor" : false
  end

end
