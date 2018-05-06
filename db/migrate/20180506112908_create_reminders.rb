class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders do |t|
      t.string :title
      t.integer :weekly_frequency
      t.text :description
    end
  end
end
