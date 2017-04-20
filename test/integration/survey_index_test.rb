require 'test_helper'

class SurveyIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @survey = surveys(:survey)
  end

  test "survey index should have survey" do
    sign_in(@user)
    get surveys_path
    assert_template 'surveys/index'
    assert_match @survey.title, response.body, count: 1
    assert_select 'a[href=?]', survey_path(@survey)
  end
end