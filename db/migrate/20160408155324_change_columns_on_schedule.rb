class ChangeColumnsOnSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :question
    remove_column :schedules, :answer
    add_column :schedules, :work, :string
    add_column :schedules, :sleep, :string
    add_column :schedules, :bathroom, :string
    add_column :schedules, :kitchen, :string
  end
end
