class ChangeColumnsOnDesiredHabit < ActiveRecord::Migration
  def change
    remove_column :desired_habits, :question
    remove_column :desired_habits, :answer
    add_column :desired_habits, :drinking, :string
    add_column :desired_habits, :four_twenty, :string
    add_column :desired_habits, :partying, :string
    add_column :desired_habits, :overnight_visitors, :string
    add_column :desired_habits, :music, :string
  end
end
