class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      @days = params[:days]
      unless @days.nil?
        @days.each do |day, value|
          if value == '1'
            time = "#{params[:"#{day}_time"]} #{params[:time_zone]}".to_time
            @task.create_reminders(day: day, time: time, start_date: DateTime.now)
          end
        end
      end
      current_user.create_future_reminder_texts(@task)
      current_user.send_confirmation_reminder_text if @task.reminders.any?
      flash[:success] = "Task created!"
      redirect_to current_user
    else
      message = "Invalid task: "
      @task.errors.full_messages.each do |error|
        message += "#{error} "
      end
      flash[:danger] = message
      redirect_to current_user
    end
  end

  def update
    @task = Task.find(params[:id])
    if params[:task][:completed] == "true"
      @task.update_attributes(completed: true, completed_at: Time.zone.now)
      flash[:success] = "Task completed!"
      redirect_to current_user
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date)
  end
end
