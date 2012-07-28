class Answer < ActiveRecord::Base
  attr_accessible :question_id, :description

  belongs_to :question

  validates :question_id, :presence => true, :numericality => true
  validates_presence_of :description

 end
