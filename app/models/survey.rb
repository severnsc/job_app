class Survey < ApplicationRecord
  has_many :questions
  has_many :answers
  belongs_to :job
  accepts_nested_attributes_for :questions
  validates :title, presence: true
end
