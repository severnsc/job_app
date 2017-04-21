class AnswersController < ApplicationController

  def create
    @survey = Survey.find(params["survey_id"])
    @job = Job.find(params["job_id"])
    attrs = answers_params[:answers_attributes].to_h
    answers = []
    attrs.count.times do |i|
      answer = @survey.answers.build(answers_params[:answers_attributes][i.to_s])
      answer.question = @survey.questions[i]
      answers << answer
    end
    answers.each do |a|
      if a.save
        next
      else
        flash[:danger] = "Invalid answers! Try again"
        redirect_to job_survey_submit_path(@job, survey_id: @survey.id)
      end
    end
    flash[:success] = "Survey completed!"
    redirect_to job_path(@job)
  end

  private

  def answers_params
    params.require(:survey).permit(answers_attributes: [:id, :content])
  end
end
