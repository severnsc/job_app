class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :job
  belongs_to :survey
  has_many :answers
end
