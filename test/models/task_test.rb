require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  
  def setup
    @task = Task.new(name: "Task", description: "This is a task", user: users(:user))
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "should have a name" do
    @task.name = " "
    assert_not @task.valid?
  end

  test "should have a description" do
    @task.description = "  "
    assert_not @task.valid?
  end

  test "description should be 255 or less" do
    @task.description = "a" * 256
    assert_not @task.valid?
  end

  test "should have a user" do
    @task.user = nil
    assert_not @task.valid?
  end
end
