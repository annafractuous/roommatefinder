class ChangeToUserIdOnAllModels < ActiveRecord::Migration
  def change
    add_column :cleanlinesses, :user_id, :integer
    add_column :desired_cleanlinesses, :user_id, :integer
    add_column :schedules, :user_id, :integer
    add_column :desired_schedules, :user_id, :integer
    add_column :habits, :user_id, :integer
    add_column :desired_habits, :user_id, :integer

  end
end
