class Question < ActiveRecord::Base
  attr_accessible :student_id, :tutor_id, :subject_id, :description, :status

  belongs_to :tutor
  belongs_to :student
  belongs_to :subject

  validates_presence_of :status
  validates_presence_of :student_id
  validates_presence_of :tutor_id
  validates_presence_of :description
 end
