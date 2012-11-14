class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :type, :status, :password_confirmation
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates_presence_of :name
  validates_presence_of :status
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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def send_validation_token
    generate_token(:validation_token)
    self.validation_token_sent_at = Time.zone.now
    save!
    UserMailer.validation_token(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.base64.tr("+/", "-_")
    end while User.exists?(column => self[column])
  end
end
