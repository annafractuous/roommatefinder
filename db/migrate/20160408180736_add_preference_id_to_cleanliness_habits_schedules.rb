class AddPreferenceIdToCleanlinessHabitsSchedules < ActiveRecord::Migration
  def change
    remove_column :desired_cleanlinesses, :profile_id
    remove_column :desired_schedules, :profile_id
    remove_column :desired_habits, :profile_id
    add_column :desired_cleanlinesses, :preference_id, :integer
    add_column :desired_schedules, :preference_id, :integer
    add_column :desired_habits, :preference_id, :integer
  end
end
