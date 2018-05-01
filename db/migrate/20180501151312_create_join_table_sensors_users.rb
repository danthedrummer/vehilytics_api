class CreateJoinTableSensorsUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :sensors, :users do |t|
      # t.index [:sensor_id, :user_id]
      # t.index [:user_id, :sensor_id]
    end
  end
end
