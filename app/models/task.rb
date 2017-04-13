class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true,length: {maximum: 255}
  belongs_to :user
  has_many :reminders
  accepts_nested_attributes_for :reminders
end
