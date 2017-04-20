require 'test_helper'

class EditJobTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @job = jobs(:job)
  end

  test "Edit the job" do
    sign_in(@user)
    get edit_job_path(@job)
    assert_template 'jobs/edit'
    assert_select 'form[action=?]', job_path(@job)
    position = "Some position"
    company = "Some company"
    location = "Some place"
    pay = "Some money"
    requirements = "Some requirements"
    responsibilities = "Some responsibilities"
    patch job_path(@job), params: { job: { position: position,
                                           company: company,
                                           location: location,
                                           pay: pay,
                                           responsibilities: responsibilities,
                                           requirements: requirements}}
    assert_redirected_to job_path(@job)
    assert_not flash.empty?
    assert_equal position, @job.reload.position
    assert_equal company, @job.company
    assert_equal location, @job.location
    assert_equal pay, @job.pay
    assert_equal requirements, @job.requirements
    assert_equal responsibilities, @job.responsibilities
    follow_redirect!
    assert_template 'jobs/show'
  end
end