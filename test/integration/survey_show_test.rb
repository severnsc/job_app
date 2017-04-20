require 'test_helper'

class SurveyShowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @survey = surveys(:survey)
  end

  test "survey page shows survey title and questions content" do
    sign_in(@user)
    get survey_path(@survey)
    assert_template 'surveys/show'
    assert_match @survey.title, response.body
    @survey.questions.each do |q|
      assert_match q.content, response.body
    end
  end

  test "survey page shows edit and delete links" do
    sign_in(@user)
    get survey_path(@survey)
    assert_template 'surveys/show'
    assert_select "a[href=?]", edit_survey_path(@survey)
    assert_select "a[href=?]", survey_path(@survey), text: 'Delete'
  end

end