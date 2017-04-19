class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true,length: {maximum: 255}
  belongs_to :user, required: true
  has_many :reminders
  accepts_nested_attributes_for :reminders

  def create_reminders(args)
    day = args.fetch(:day)
    time = args.fetch(:time)
    start_date = args.fetch(:start_date, DateTime.now)
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

  def create_reminder_texts(reminders)
    reminders.each do |reminder|
      reminder.job = new_twilio_client.messages.delay(run_at: reminder.datetime).create(
        from: ENV['PHONE_NUMBER'],
        to: user.phone_number,
        body: reminder.task.description
      )
    end
  end
 
  private

  def new_twilio_client
    Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
  end

end