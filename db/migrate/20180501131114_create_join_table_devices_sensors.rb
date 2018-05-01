class CreateJoinTableDevicesSensors < ActiveRecord::Migration[5.1]
  def change
    create_join_table :devices, :sensors do |t|
      # t.index [:device_id, :sensor_id]
      # t.index [:sensor_id, :device_id]
    end
  end
end
