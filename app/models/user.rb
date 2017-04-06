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
    tasks.where("completed = ?", false)
  end

  def completed_tasks
    tasks.where("completed = ?", true)
  end
end
