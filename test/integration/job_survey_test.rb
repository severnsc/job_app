require 'test_helper'

class JobSurveyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @job = jobs(:job)
    @survey = surveys(:survey)
    Submission.delete_all
  end

  test "take job suvey" do
    sign_in(@user)
    get job_path(@job)
    assert_template 'jobs/show'
    assert_select 'a[href=?]', job_survey_path(@job)
    get job_survey_path(@job)
    assert_template 'jobs/survey'
    assert_select 'form[action=?]', job_survey_submission_path(@job)
    get job_survey_submission_path(@job, survey_id: @survey.id)
    assert_template 'jobs/survey_submit'
    assert_select 'form[action=?]', answers_path
    assert_match @survey.title, response.body
    @survey.questions.each do |q|
      assert_match q.content, response.body
    end
    assert_difference 'Answer.count', 2 do
      post answers_path, params: { survey: { answers_attributes: {"0" => {content: 5},
                                                                  "1" => {content: 4}}},
                                   survey_id: @survey.id,
                                   job_id: @job.id}
    end
    assert_equal 1, Submission.count
    assert_redirected_to job_path(@job)
    assert_not flash.empty?
    follow_redirect!
    assert_template 'jobs/show'
    assert_match "Survey Results", response.body
    assert_match "5", response.body
    assert_match "4", response.body
  end
end