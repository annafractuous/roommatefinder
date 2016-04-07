class AddQuestionsToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :cleanliness, :string
    add_column :preferences, :schedule, :string
    add_column :preferences, :social_habits, :string
    add_column :preferences, :substance_habits, :string
    add_column :preferences, :pets, :string
  end
end
