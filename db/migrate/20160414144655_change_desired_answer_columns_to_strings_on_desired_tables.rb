class ChangeDesiredAnswerColumnsToStringsOnDesiredTables < ActiveRecord::Migration
  def change
    change_column :desired_cleanlinesses, :kitchen, :string
    change_column :desired_cleanlinesses, :bathroom, :string
    change_column :desired_cleanlinesses, :common_space, :string

    change_column :desired_schedules, :work, :string
    change_column :desired_schedules, :sleep, :string
    change_column :desired_schedules, :bathroom, :string
    change_column :desired_schedules, :kitchen, :string

    change_column :desired_habits, :drinking, :string
    change_column :desired_habits, :four_twenty, :string
    change_column :desired_habits, :partying, :string
    change_column :desired_habits, :overnight_visitors, :string
    change_column :desired_habits, :music, :string
  end
end
