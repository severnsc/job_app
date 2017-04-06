class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, length: {maximum: 255}
  belongs_to :user
end
