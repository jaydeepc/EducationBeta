class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :tutor_id
      t.string :upload_type
      t.integer :file_size

      t.timestamps
    end
  end
end
