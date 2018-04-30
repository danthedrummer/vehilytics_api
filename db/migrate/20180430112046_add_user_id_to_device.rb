class AddUserIdToDevice < ActiveRecord::Migration[5.1]
  def change
    add_reference :devices, :user, index: true, foreign_key: true
  end
end
