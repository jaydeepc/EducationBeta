class ChangeFileSizeToUploadFileSize < ActiveRecord::Migration
  def up
    rename_column :uploads, :file_size, :upload_file_size
  end

  def down
    rename_column :uploads, :upload_file_size, :file_size
  end
end
