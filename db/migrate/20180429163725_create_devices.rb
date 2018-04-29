class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_name, null: false

      t.timestamps
    end
    add_index :devices, :device_name, unique: true
  end
end
