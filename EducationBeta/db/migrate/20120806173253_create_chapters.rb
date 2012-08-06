class CreateChapters < ActiveRecord::Migration
  def up
    create_table :chapters do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :chapters
  end
end
