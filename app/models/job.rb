class Job < ApplicationRecord
  belongs_to :user
  validates :position, presence: true
  validates :company, presence: true
  validates :location, presence: true
  validates :pay, presence: true
  validates :responsibilities, presence: true
  validates :requirements, presence: true
end
