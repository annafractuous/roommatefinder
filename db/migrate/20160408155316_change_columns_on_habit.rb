class ChangeColumnsOnHabit < ActiveRecord::Migration
  def change
    remove_column :habits, :question
    remove_column :habits, :answer
    add_column :habits, :drinking, :integer
    add_column :habits, :four_twenty, :integer
    add_column :habits, :partying, :integer
    add_column :habits, :overnight_visitors, :integer
    add_column :habits, :music, :integer
  end
end
