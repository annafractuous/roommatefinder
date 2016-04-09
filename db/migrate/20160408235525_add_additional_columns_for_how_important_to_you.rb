class AddAdditionalColumnsForHowImportantToYou < ActiveRecord::Migration
  def change
    add_column :desired_cleanlinesses, :kitchen_importance, :integer
    add_column :desired_cleanlinesses, :bathroom_importance, :integer
    add_column :desired_cleanlinesses, :common_room_importance, :integer

    add_column :desired_schedules, :kitchen_importance, :integer
    add_column :desired_schedules, :bathroom_importance, :integer
    add_column :desired_schedules, :work_importance, :integer
    add_column :desired_schedules, :sleep_importance, :integer

    add_column :desired_habits, :drinking_importance, :integer
    add_column :desired_habits, :partying_importance, :integer
    add_column :desired_habits, :music_importance, :integer
    add_column :desired_habits, :four_twenty_importance, :integer
    add_column :desired_habits, :overnight_visitors_importance, :integer

  end
end
