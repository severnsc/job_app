class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.datetime :due_date
      t.boolean :completed, default: false
      t.references :user

      t.timestamps
    end
  end
end
