require 'test_helper'

class DeleteSurveyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @other_user = users(:other_user)
    @survey = surveys(:survey)
  end

  test "delete survey as wrong user" do
    sign_in(@other_user)
    assert_no_difference 'Survey.count' do
      delete survey_path(@survey)
    end
    assert_redirected_to user_path(@other_user)
  end

  test "delete survey as correct user" do
    sign_in(@user)
    assert_difference 'Survey.count', -1 do
      delete survey_path(@survey)
    end
    assert_redirected_to user_path(@user)
    assert_not flash.empty?
  end
end