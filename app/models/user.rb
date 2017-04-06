class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :tasks

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def uncompleted_tasks
    task_list = []
    task_list << tasks.find_by_completed(false)
  end

  def completed_tasks
    task_list = []
    task_list << tasks.find_by_completed(true)
  end
end
