class RemovePreferenceIdFromDesireds < ActiveRecord::Migration
  def change
    remove_column :desired_cleanlinesses, :preference_id
    remove_column :desired_schedules, :preference_id
    remove_column :desired_habits, :preference_id
  end
end
