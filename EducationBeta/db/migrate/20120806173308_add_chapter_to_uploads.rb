class AddChapterToUploads < ActiveRecord::Migration
  def up
    add_column :uploads, :chapter_id, :integer
  end

  def down
    remove_column :uploads, :chapter_id
  end
end
