class SurveysController < ApplicationController
  before_action :authenticate_user!

  def new
    @survey = Survey.new
    3.times {@survey.questions.build}
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

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(survey_params)
      flash[:success] = "Survey updated!"
      redirect_to survey_path(@survey)
    else
      render 'edit'
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:title, questions_attributes: [:content, answers_attributes: [:content]])
  end
end
