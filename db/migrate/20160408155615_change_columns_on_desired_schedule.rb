class ChangeColumnsOnDesiredSchedule < ActiveRecord::Migration
  def change
    remove_column :desired_schedules, :question
    remove_column :desired_schedules, :answer
    add_column :desired_schedules, :work, :integer
    add_column :desired_schedules, :sleep, :integer
    add_column :desired_schedules, :bathroom, :integer
    add_column :desired_schedules, :kitchen, :integer
  end
end
