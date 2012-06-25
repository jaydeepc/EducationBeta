class CreateUpload < ActiveRecord::Migration
 def change
    create_table :uploads do |t|
      t.integer :user_id
      t.string :document_file_name
      t.string :document_content_type
      t.integer :document_file_size
      t.datetime :document_updated_at
      t.timestamps
    end
  end
end
