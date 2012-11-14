class RenameValidationUuidInUser < ActiveRecord::Migration
  def up
    rename_column(:users, :validation_uuid, :validation_token)
  end

  def down
    rename_column(:users, :validation_token, :validation_uuid)
  end
end
