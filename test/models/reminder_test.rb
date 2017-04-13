require 'test_helper'

class ReminderTest < ActiveSupport::TestCase
  
  def setup
    @reminder = Reminder.new(datetime: DateTime.now, task: tasks(:task))
  end

  test "should be valid" do
    assert @reminder.valid?
  end

  test "should have date time" do
    @reminder.datetime = " "
    assert_not @reminder.valid?
  end
end
