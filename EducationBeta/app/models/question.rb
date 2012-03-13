class Question < ActiveRecord::Base
  attr_accessible :student_id, :tutor_id, :subject_id, :description, :status
 end
