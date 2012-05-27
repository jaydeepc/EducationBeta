class TutorSubject < ActiveRecord::Base
  attr_accessible :tutor_id, :subject_id

  validates :tutor_id, :presence => true, :numericality => true
  validates :subject_id, :presence => true, :numericality => true

  def self.find_all_tutors_by_subject(subject)
    begin
      subject_id = Subject.find_by_subject(subject).id
      tutor_ids = self.find_all_by_subject_id(subject_id).collect(&:tutor_id)
      tutors = []
      tutor_ids.each do |tutor_id|
        tutors << Tutor.find(tutor_id)
      end
      return tutors
    rescue
      return nil
    end
  end
 end
