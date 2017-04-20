require 'test_helper'

class EditingNewTaskTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @task = tasks(:task)
  end

  test "Edit task" do
    sign_in(@user)
    get edit_task_path(@task)
    assert_template 'tasks/edit'
    assert_select 'form[action=?]', task_path(@task)
    task_name = "Edited Task"
    task_description = "This task was edited"
    task_due_date = DateTime.now.utc + 14.days
    patch task_path(@task), params: { task: { name: task_name,
                                             description: task_description,
                                             due_date: task_due_date},
                                    days: {monday: '1'},
                                    monday_time: '14:00 PM',
                                    time_zone: 'EDT'}
    assert_redirected_to user_path(@user)
    assert_not flash.empty?
    assert_equal task_name, @task.reload.name
    assert_equal task_description, @task.description
    assert_in_delta task_due_date, @task.due_date, 1.second
    assert @task.reminders.any? {|r| r.datetime.monday?}
    assert @task.reminders.any? {|r| r.datetime.hour == 18}
    follow_redirect!
    assert_template 'users/show'
  end
end