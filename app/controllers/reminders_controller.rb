class RemindersController < ApplicationController

  def edit
    @reminder = Reminder.find(params[:id])
  end

  def update
    @reminder = Reminder.find(params[:id])
    if @reminder.update_attributes(reminder_params)
      @reminder.job.update_attribute(:run_at, params[:reminder][:datetime])
      flash[:success] = "Reminder updated!"
      redirect_to edit_task_path(@reminder.task)
    else
      flash[:danger] = "Invalid Reminder Datetime!"
      redirect_to edit_task_path(@reminder.task)
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.delete
    flash[:success] = "Reminder Deleted!"
    redirect_to edit_task_path(@reminder.task)
  end

  private

  def reminder_params
    params.require(:reminder).permit(:datetime)
  end
end
