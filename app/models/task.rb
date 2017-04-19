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
    datetime = start_date + 1.day
    until datetime >= due_date
      if datetime.strftime("%A").downcase == day
        reminders.create(datetime: datetime.change({hour: time.hour, minute: time.min}))
        datetime += 7.days
      else
        datetime += 1.day
      end
    end
  end

end