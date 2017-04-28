class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :job
  belongs_to :survey
  has_many :answers
  accepts_nested_attributes_for :answers
end
