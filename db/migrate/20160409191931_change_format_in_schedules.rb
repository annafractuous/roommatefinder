class ChangeFormatInSchedules < ActiveRecord::Migration
  def change
    change_column :schedules, :work, :integer
    change_column :schedules, :sleep, :integer
    change_column :schedules, :bathroom, :integer
    change_column :schedules, :kitchen, :integer
  end
end
