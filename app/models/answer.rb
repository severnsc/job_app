class Answer < ApplicationRecord
  belongs_to :survey
  belongs_to :question
  validates :content, presence: true
end
