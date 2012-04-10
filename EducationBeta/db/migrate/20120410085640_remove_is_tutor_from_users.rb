class RemoveIsTutorFromUsers < ActiveRecord::Migration
  def up
    remove_column "users", "is_tutor"
  end

  def down
    add_column "users", "is_tutor", :boolean, :default => false
  end
end
