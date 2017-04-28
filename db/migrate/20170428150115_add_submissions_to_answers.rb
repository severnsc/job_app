class AddSubmissionsToAnswers < ActiveRecord::Migration[5.0]
  def change
    remove_column :answers, :survey_id
    add_reference :answers, :submission
  end
end
