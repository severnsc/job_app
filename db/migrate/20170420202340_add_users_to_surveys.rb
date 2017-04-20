class AddUsersToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_reference :surveys, :user
  end
end
