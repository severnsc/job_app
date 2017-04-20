require 'test_helper'

class NewSurveyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
  end

  test "creating a new survey" do
    sign_in(@user)
    get new_survey_path
    assert_template 'surveys/new'
    assert_select 'form[action=?]', surveys_path
    assert_difference 'Survey.count' do
      post surveys_path, params: { survey: { title: "New Survey",
                                             questions_attributes: {'0' => {
                                              content: "This is a question",
                                              answers_attributes: {'0' => {
                                                content: "this is an answer"
                                                }}
                                              }}}}
    end
    survey = assigns(:survey)
    assert_redirected_to survey_path(survey)
    assert_not flash.empty?
    follow_redirect!
    assert_template 'surveys/show'
    assert_match "New Survey", response.body
  end
end