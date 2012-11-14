class AddValidationTokenSentAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :validation_token_sent_at, :datetime

  end
end
