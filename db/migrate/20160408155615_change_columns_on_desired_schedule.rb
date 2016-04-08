class ChangeColumnsOnDesiredSchedule < ActiveRecord::Migration
  def change
    remove_column :desired_schedules, :question
    remove_column :desired_schedules, :answer
    add_column :desired_schedules, :work, :string
    add_column :desired_schedules, :sleep, :string
    add_column :desired_schedules, :bathroom, :string
    add_column :desired_schedules, :kitchen, :string
  end
end
