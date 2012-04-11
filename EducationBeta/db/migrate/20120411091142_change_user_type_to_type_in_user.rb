class ChangeUserTypeToTypeInUser < ActiveRecord::Migration
  def self.up
    rename_column "users", "user_type", "type" 
  end

  def down
    rename_column "users", "type", "user_type" 
  end
end
