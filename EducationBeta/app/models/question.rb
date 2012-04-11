class Question < ActiveRecord::Base
  attr_accessible :student_id, :tutor_id, :subject_id, :description, :status

  belongs_to :tutor
  belongs_to :student
  belongs_to :subject

  validates_presence_of :status
  validates :student_id, :presence => true, :numericality => true
  validates :tutor_id, :presence => true, :numericality => true
  validates :subject_id, :presence => true, :numericality => true
  validates_presence_of :description
 end
