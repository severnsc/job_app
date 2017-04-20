class Reminder < ApplicationRecord
  belongs_to :task
  has_one :delayed_job, class_name: "::Delayed::Job"
  validates :datetime, presence: true

  def create_reminder_text(args)
    user = args.fetch(:user)
    body = args.fetch(:body, 'Reminder')
    delayed_job = new_twilio_client.messages.delay(run_at: datetime).create(
      from: ENV['PHONE_NUMBER'],
      to: user.phone_number,
      body: body
      )
  end
 
  private

  def new_twilio_client
    Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
  end

end
