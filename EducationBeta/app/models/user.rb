class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :type, :status, :validation_uuid

  before_save :encrypt_password

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
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) && user.status == 'registered'
      user
    else
      nil
    end
  end

  def is_tutor?
    true ? self.type == "Tutor" : false
  end

  private
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
