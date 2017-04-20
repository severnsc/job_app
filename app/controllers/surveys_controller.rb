class SurveysController < ApplicationController

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      flash[:success] = "Survey created!"
      redirect_to survey_path(@survey)
    else
      render 'new'
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  private

  def survey_params
    params.require(:survey).permit(:title, questions_attributes: [:content, answers_attributes: [:content]])
  end
end
