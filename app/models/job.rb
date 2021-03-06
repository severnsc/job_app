class Job < ApplicationRecord
  before_save :downcase_email

  belongs_to :user
  has_one :submission
  validates :position, presence: true
  validates :company, presence: true
  validates :location, presence: true
  validates :pay, presence: true
  validates :responsibilities, presence: true
  validates :requirements, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :contact_email, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false},
            allow_blank: true

  private

  def downcase_email
    contact_email.downcase! unless contact_email.nil?
  end
end
