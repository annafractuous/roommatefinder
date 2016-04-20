class ChangeColumnsOnDesiredHabit < ActiveRecord::Migration
  def change
    remove_column :desired_habits, :question
    remove_column :desired_habits, :answer
    add_column :desired_habits, :drinking, :integer
    add_column :desired_habits, :four_twenty, :integer
    add_column :desired_habits, :partying, :integer
    add_column :desired_habits, :overnight_visitors, :integer
    add_column :desired_habits, :music, :integer
  end
end
