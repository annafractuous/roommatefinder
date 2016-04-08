class RemoveColumnsFromProfilesAndPreferences < ActiveRecord::Migration
  def change
    remove_column :profiles, :pets
    remove_column :profiles, :cleanliness
    remove_column :profiles, :schedule
    remove_column :profiles, :social_habits
    remove_column :profiles, :substance_habits
    remove_column :preferences, :pets
    remove_column :preferences, :cleanliness
    remove_column :preferences, :schedule
    remove_column :preferences, :social_habits
    remove_column :preferences, :substance_habits
  end
end
