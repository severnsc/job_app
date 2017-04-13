class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.string :day_of_the_week
      t.time :time
      t.references :task

      t.timestamps
    end
  end
end
