class AddRemindersToDelayedJobs < ActiveRecord::Migration[5.0]
  def change
    add_reference :delayed_jobs, :reminder
  end
end
