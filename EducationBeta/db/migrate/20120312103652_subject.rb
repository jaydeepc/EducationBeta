  def up
class CreateSubjects < ActiveRecord::Migration
    create_table :subjects do |t|
      t.string :subject
      t.timestamps
    end
  end

  def down
    drop_table :subjects
  end
end
