class AddQuestionsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :cleanliness, :string
    add_column :profiles, :schedule, :string
    add_column :profiles, :social_habits, :string
    add_column :profiles, :substance_habits, :string
    add_column :profiles, :pets, :string
  end
end
