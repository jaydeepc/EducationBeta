class AddStandardToUploads < ActiveRecord::Migration
  def up
    add_column :uploads, :standard_id, :integer
  end

  def down
    remove_column :uploads, :standard_id
  end
end
