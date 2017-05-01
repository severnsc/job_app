class JobsController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      flash[:success] = "Job created!"
      redirect_to job_path(@job)
    else
      render 'new'
    end
  end

  def index
    @jobs = current_user.jobs
  end

  def show
    @job = Job.find(params[:id])
    @answers = @job.submission.answers unless @job.submission.nil?
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "Job updated!"
      redirect_to job_path(@job)
    else
      render 'edit'
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.delete
    flash[:success] = "Job deleted!"
    redirect_to current_user
  end

  def survey
    @job = Job.find(params[:id])
    @surveys = Survey.all
  end

  def survey_submit
    @job = Job.find(params[:id])
    if params[:survey_id]
      @survey = Survey.find(params[:survey_id])
      @submission = @survey.submissions.build
      submission_answers = []
      @survey.questions.count.times do |i|
        submission_answers << @submission.answers.build
        @survey.questions[i].answers.build
      end
      @questions = @survey.questions
      @answers = submission_answers
    else
      redirect_to new_survey_path
    end
  end

  private

  def job_params
    params.require(:job).permit(:company, :position, :location, :pay, :contact_name, :contact_email, :contact_phone, :benefits, :responsibilities, :requirements)
  end

end
