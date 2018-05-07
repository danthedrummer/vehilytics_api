class CreateSensorDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :sensor_descriptions do |t|
      t.text :info, null: false
      t.float :upper_range
      t.float :lower_range
      
      t.references :sensor, foreign_key: true

      t.timestamps
    end
  end
end
