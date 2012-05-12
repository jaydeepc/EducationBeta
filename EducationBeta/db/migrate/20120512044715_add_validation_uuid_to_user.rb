class AddValidationUuidToUser < ActiveRecord::Migration
  def self.up
    add_column "users", "validation_uuid", :string
  end

  def self.down
    remove_column "users", "validation_uuid"
  end
end
