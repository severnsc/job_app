class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :position
      t.string :company
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :location
      t.string :pay
      t.text :benefits
      t.text :responsibilities
      t.text :requirements
      t.references :user

      t.timestamps
    end
  end
end
