class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :tasks
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def uncompleted_tasks
    tasks.where("completed = ?", false)
  end

  def completed_tasks
    tasks.where("completed = ?", true)
  end

  def new_twilio_client
    @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
  end

  def send_confirmation_reminder_text
    @client = new_twilio_client
    @client.messages.create(
      from: ENV['PHONE_NUMBER'],
      to: phone_number,
      body: 'Your task has been created!'
    )
  end

  def create_future_reminder_texts(task)
    @client = new_twilio_client
    task.reminders.each do |reminder|
      @client.messages.delay(run_at: reminder.datetime).create(
        from: ENV['PHONE_NUMBER'],
        to: phone_number,
        body: task.description
      )
    end
  end

end
