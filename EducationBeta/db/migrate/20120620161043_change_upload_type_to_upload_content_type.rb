class ChangeUploadTypeToUploadContentType < ActiveRecord::Migration
  def up
    rename_column :uploads, :upload_type, :upload_content_type
  end

  def down
    rename_column :uploads, :upload_content_type, :upload_type
  end
end
