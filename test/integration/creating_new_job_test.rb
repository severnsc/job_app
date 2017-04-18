require 'test_helper'

class CreatingNewJobTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
  end

  test "creating a new job" do
    sign_in(@user)
    get new_job_path
    assert_template 'jobs/new'
    assert_difference 'Job.count' do
      post jobs_path, params: { job: { position: "Job",
                                       company: "Company",
                                       location: "There",
                                       pay: "Money",
                                       responsibilities: "Stuff",
                                       requirements: "things"}}
    end
    job = assigns(:job)
    assert_includes @user.reload.jobs, job
  end
end