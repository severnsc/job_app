require 'test_helper'

class CreatingNewTaskTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
  end

  test "creating a task with reminders creates the associated objects" do
    sign_in(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select "form[action=?]", tasks_path
    assert_difference 'Task.count' do
      post tasks_path, params: { task: { name: "Task",
                                         description: "This is a task",
                                         due_date: DateTime.now + 7.days},
                                  days: { sunday: '1'},
                                  sunday_time: '13:00 PM',
                                  time_zone: 'EDT'}
    end
    task = assigns(:task)
    assert_includes @user.reload.tasks, task
    assert task.reminders.any?
    assert_not flash.empty?
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_select 'div.task', count: 2
  end 

end