class AddIsTutorToUser < ActiveRecord::Migration
  def self.up
    add_column "users", "is_tutor", :boolean, :default => false
  end

  def self.down
    remove_column "users", "is_tutor"
  end
end
