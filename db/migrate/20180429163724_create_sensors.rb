class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.string :name, null: false
      t.string :shortname, null: false
      t.string :unit, null: false
    end
    add_index :sensors, :name, unique: true
    add_index :sensors, :shortname, unique: true
  end
end
