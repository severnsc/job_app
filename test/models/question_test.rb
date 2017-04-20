require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  
  def setup
    @question = Question.new(content: "This is a question")
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "should have content" do
    @question.content = " "
    assert_not @question.valid?
  end

end
