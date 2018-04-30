class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      ## Database authenticatable
      t.string :email, null: false
      t.string :device_name, null: false
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps
    end
    add_index :devices, :email, unique: true
    add_index :devices, :device_name, unique: true
    add_index :devices, :reset_password_token, unique: true
  end
end
