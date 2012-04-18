class CreateAnswer < ActiveRecord::Migration
  def up
    create_table :answers do |t|
      t.integer :question_id
      t.string :description
      t.timestamps
    end
  end

  def down
    drop_table :answers
  end
end
