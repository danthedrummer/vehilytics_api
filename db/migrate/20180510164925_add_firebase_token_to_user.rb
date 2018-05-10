class AddFirebaseTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firebase_token, :string, index: true
  end
end
