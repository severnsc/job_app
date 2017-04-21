class Survey < ApplicationRecord
  has_many :questions
  has_many :answers
  belongs_to :job
  belongs_to :user
  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :answers
  validates :title, presence: true
end
