class ChangeFormatInDesiredSchedules < ActiveRecord::Migration
  def change
    change_column :desired_schedules, :work, :integer
    change_column :desired_schedules, :sleep, :integer
    change_column :desired_schedules, :bathroom, :integer
    change_column :desired_schedules, :kitchen, :integer
  end
end
