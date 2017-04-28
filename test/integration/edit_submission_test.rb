require 'test_helper'

class EditSubmissionTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @submission = submissions(:submission)
    @user = users(:user)
    @job = jobs(:job)
  end

  test "edit a submission from the job page" do
    sign_in(@user)
    get job_path(@job)
    assert_template 'jobs/show'
    assert_match "Edit Submission", response.body
    assert_select 'a[href=?]', edit_submission_path(@submission)
    get edit_submission_path(@submission)
    assert_template 'submissions/edit'
    assert_select 'form[action=?]', submission_path(@submission)
    patch submission_path(@submission), params: { submission: { answers_attributes: {"0" => {content: 5},
                                                                  "1" => {content: 4}}}}
    assert_redirected_to job_path(@job)
    assert_not flash.empty?
    follow_redirect!
    assert_template 'jobs/show'
    assert_match "5", response.body
    assert_match "4", response.body
  end
end