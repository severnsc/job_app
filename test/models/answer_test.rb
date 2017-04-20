require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  def setup
    @answer = Answer.new(content: "this is an answer")
  end

  test "should be valid" do
    assert @answer.valid?
  end

  test "should have content" do
    @answer.content = " "
    assert_not @answer.valid?
  end

end
