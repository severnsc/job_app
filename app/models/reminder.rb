class Reminder < ApplicationRecord
  belongs_to :task
  validates :datetime, presence: true
end
