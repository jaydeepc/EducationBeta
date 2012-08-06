class AddSubjectToUploads < ActiveRecord::Migration
  def up
    add_column :uploads, :subject_id, :integer
  end

  def down
    remove_column :uploads, :subject_id
  end
end
