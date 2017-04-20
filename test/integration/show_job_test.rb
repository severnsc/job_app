require 'test_helper'

class ShowJobTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @job = jobs(:job)
  end

  test "should have job information on page" do
    sign_in(@user)
    get job_path(@job)
    assert_template 'jobs/show'
    assert_match @job.position, response.body
    assert_match @job.company, response.body
    assert_match @job.location, response.body
    assert_match @job.pay, response.body
    assert_match @job.responsibilities, response.body
    assert_match @job.requirements, response.body
  end

  test "should have link to survey" do
    sign_in(@user)
    get job_path(@job)
    assert_template 'jobs/show'
    assert_select 'a[href=?]', job_survey_path(@job)
  end
end