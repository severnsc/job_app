class SubmissionsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @submission = Submission.find(params[:id])
    @answers = @submission.answers
  end

  def update
    @submission = Submission.find(params[:id])
    if @submission.update_attributes(submission_params)
      flash[:success] = "Submission updated!"
      redirect_to job_path(@submission.job)
    else
      render 'edit'
    end
  end

  private

  def submission_params
    params.require(:submission).permit(answers_attributes:[:id, :content])
  end

end
