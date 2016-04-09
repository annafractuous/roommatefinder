class ChangeFormatInDesiredHabits < ActiveRecord::Migration
  def change
    change_column :desired_habits, :drinking, :integer
    change_column :desired_habits, :four_twenty, :integer
    change_column :desired_habits, :partying, :integer
    change_column :desired_habits, :overnight_visitors, :integer
    change_column :desired_habits, :music, :integer
  end
end
