class TasksController < ApplicationController

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      @days = params[:days]
      @days.each do |day, value|
      if value == '1'
        #Create a reminder for each weekday corresponding to the day selected at the time selected until the due date
        datetime = DateTime.now + 1.day
        time = "#{params[:"#{day}_time"]} #{params[:time_zone]}".to_time
        until datetime >= params[:task][:due_date]
          if datetime.strftime("%A").downcase == day
            @task.reminders.create(datetime: datetime.change({hour: time.hour, minute: time.min}))
            datetime += 7.days
          else
            datetime += 1.day
          end
        end
      end
    end
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
