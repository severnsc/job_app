require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  
  def setup
    @survey = Survey.new(title: "Title")
  end

  test "should be valid" do
    assert @survey.valid?
  end

  test "should have title" do
    @survey.title = " "
    assert_not @survey.valid?
  end
end
