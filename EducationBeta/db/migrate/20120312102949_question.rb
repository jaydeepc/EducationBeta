class Question < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.integer :student_id
      t.integer :tutor_id
      t.integer :subject_id
      t.string :description
      t.string :status
      t.timestamps
    end
  end

  def down
    drop_table :questions
  end
end
