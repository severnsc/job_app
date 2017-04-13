class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @task = @user.tasks.build
  end
end
