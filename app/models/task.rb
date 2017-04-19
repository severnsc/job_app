class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true,length: {maximum: 255}
  belongs_to :user, required: true
  has_many :reminders
  accepts_nested_attributes_for :reminders

  def create_reminders(args)
    day = args.fetch(:day)
    time = args.fetch(:time)
    start_date = args.fetch(:start_date)
    created_reminders = []
    until start_date >= due_date
      if start_date.strftime("%A").downcase == day
        created_reminders << reminders.find_or_create_by(datetime: start_date.change({hour: time.hour, minute: time.min}))
        start_date += 7.days
      else
        start_date += 1.day
      end
    end
    created_reminders
  end

end