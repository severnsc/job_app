class TasksController < ApplicationController

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
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
