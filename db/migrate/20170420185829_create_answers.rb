class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :survey
      t.references :question

      t.timestamps
    end
  end
end
