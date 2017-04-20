require 'test_helper'

class EditSurveyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @survey = surveys(:survey)
    @other_user = users(:other_user)
  end

  test "edit survey as incorrect user" do
    sign_in(@other_user)
    get edit_survey_path(@survey)
    assert_redirected_to user_path(@other_user)
  end

  test "editing a survey" do
    sign_in(@user)
    get edit_survey_path(@survey)
    assert_template 'surveys/edit'
    assert_select 'form[action=?]', survey_path(@survey)
    survey_title = "New survey title"
    question_content = "New question content"
    patch survey_path(@survey), params: { survey: { title: survey_title,
                                                    questions_attributes: {'0' => {
                                                      content: question_content
                                                      }}}}
    assert_equal survey_title, @survey.reload.title
    assert @survey.questions.any? {|q| q.content == question_content}
    assert_redirected_to survey_path(@survey)
    assert_not flash.empty?
    follow_redirect!
    assert_template 'surveys/show'
    assert_match survey_title, response.body
    assert_match question_content, response.body
  end
end