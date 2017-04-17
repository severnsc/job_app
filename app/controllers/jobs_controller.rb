class JobsController < ApplicationController

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

  private

  def job_params
    params.require(:job).permit(:company, :position, :location, :pay, :contact_name, :contact_email, :contact_phone, :benefits, :responsibilites, :requirements)
  end

end