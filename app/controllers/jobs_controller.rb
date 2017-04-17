class JobsController < ApplicationController

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save

    else

    end
  end

  def index
    @jobs = current_user.jobs
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)

    else

    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.delete
    redirect_to current_user
  end

end
