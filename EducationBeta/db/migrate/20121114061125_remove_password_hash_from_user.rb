class RemovePasswordHashFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :password_hash
      end

  def down
    add_column :users, :password_hash, :string
  end
end
