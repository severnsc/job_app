require 'test_helper'

class ReminderTest < ActiveSupport::TestCase
  
  def setup
    @reminder = Reminder.new(day_of_the_week: "Monday", time: Time.new(Date.today.year, Date.today.month, Date.today.day, 1, 0, 0), task: tasks(:task))
  end

  test "should be valid" do
    assert @reminder.valid?
  end

  test "should have day of the week" do
    @reminder.day_of_the_week = " "
    assert_not @reminder.valid?
  end

  test "day should be valid" do
    invalid_days = %w[blahday moanday truesday wedsday thrisday frizday saturdal suunday]
    invalid_days.each do |day|
      @reminder.day_of_the_week = day
      assert_not @reminder.valid?, "#{day} should not be valid"
    end
  end

  test "should have time" do
    @reminder.time = ""
    assert_not @reminder.valid?
  end
end
