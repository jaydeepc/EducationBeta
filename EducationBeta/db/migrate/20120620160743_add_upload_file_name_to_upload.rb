class AddUploadFileNameToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :upload_file_name, :string

  end
end
