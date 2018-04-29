class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.decimal :value, null: false
      
      t.references :sensor, index: true, foreign_key: true
      t.references :report, foreign_key: true

      t.timestamps
    end
  end
end
