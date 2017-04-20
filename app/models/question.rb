class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
  validates :content, presence: true
  accepts_nested_attributes_for :answers
end
