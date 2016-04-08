class ChangeToUserIdOnAllModels < ActiveRecord::Migration
  def change
    add_column :cleanlinesses, :user_id, :integer
    add_column :desired_cleanlinesses, :user_id, :integer
    add_column :schedules, :user_id, :integer
    add_column :desired_schedules, :user_id, :integer
    add_column :habits, :user_id, :integer
    add_column :desired_habits, :user_id, :integer

    remove_column :cleanlinesses, :profile_id
    remove_column :desired_cleanlinesses, :profile_id
    remove_column :schedules, :profile_id
    remove_column :desired_schedules, :profile_id
    remove_column :habits, :profile_id
    remove_column :desired_habits, :profile_id

    drop_table :profiles
    drop_table :preferences
  end
end
