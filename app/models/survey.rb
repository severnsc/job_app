class Survey < ApplicationRecord
  has_many :questions
  has_many :submissions
  belongs_to :user
  accepts_nested_attributes_for :questions
  validates :title, presence: true
end
