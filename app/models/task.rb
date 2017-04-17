class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true,length: {maximum: 255}
  belongs_to :user
  has_many :reminders
  accepts_nested_attributes_for :reminders

  def create_reminders(day, time)
    datetime = DateTime.now + 1.day
    until datetime >= self.due_date
      if datetime.strftime("%A").downcase == day
        self.reminders.create(datetime: datetime.change({hour: time.hour, minute: time.min}))
        datetime += 7.days
      else
        datetime += 1.day
      end
    end
  end

end