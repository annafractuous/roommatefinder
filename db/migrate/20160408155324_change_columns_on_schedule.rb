class ChangeColumnsOnSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :question
    remove_column :schedules, :answer
    add_column :schedules, :work, :integer
    add_column :schedules, :sleep, :integer
    add_column :schedules, :bathroom, :integer
    add_column :schedules, :kitchen, :integer
  end
end
