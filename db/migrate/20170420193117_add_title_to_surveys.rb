class AddTitleToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :title, :string
  end
end
