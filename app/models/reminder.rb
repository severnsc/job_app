class Reminder < ApplicationRecord
  belongs_to :task
  DAYS_OF_THE_WEEK = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
  validates :day_of_the_week, presence: true, inclusion: {in: DAYS_OF_THE_WEEK}
  validates :time, presence: true
end
