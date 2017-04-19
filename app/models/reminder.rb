class Reminder < ApplicationRecord
  belongs_to :task
  has_one :job, class_name: "::Delayed::Job"
  validates :datetime, presence: true
end
