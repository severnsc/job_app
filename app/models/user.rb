class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :tasks
  has_many :jobs
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

  def overdue_tasks
    uncompleted_tasks.where("due_date < ?", Time.now)
  end

  def new_twilio_client
    @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
  end

  def create_future_reminder_texts(reminders)
    @client = new_twilio_client
    reminders.each do |reminder|
      reminder.job = @client.messages.delay(run_at: reminder.datetime).create(
        from: ENV['PHONE_NUMBER'],
        to: phone_number,
        body: reminder.task.description
      )
    end
  end

  def update_future_reminder_texts(reminders)
    @client = new_twilio_client
    reminders.each do |reminder|
      reminder.job = @client.messages.delay(run_at: reminder.datetime).create(
        from: ENV['PHONE_NUMBER'],
        to: phone_number,
        body: reminder.task.description
      )
    end
  end

end
