class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.datetime :time_reported, null: false
      
      t.references :device, index: true, foreign_key: true

      t.timestamps
    end
  end
end
