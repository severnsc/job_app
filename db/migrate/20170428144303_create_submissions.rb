class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.references :user
      t.references :job
      t.references :survey

      t.timestamps
    end
  end
end
