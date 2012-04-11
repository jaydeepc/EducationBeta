class Tutor < User
  has_many :questions
  def self.model_name
    User.model_name
  end
end
