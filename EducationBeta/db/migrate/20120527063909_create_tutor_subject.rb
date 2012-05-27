class CreateTutorSubject < ActiveRecord::Migration
  def up
    create_table :tutor_subjects do |t|
      t.integer :tutor_id
      t.integer :subject_id
      t.timestamps
    end
  end

  def down
    drop_table :tutor_subjects
  end
end
