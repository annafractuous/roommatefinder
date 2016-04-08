class ChangeColumnsOnHabit < ActiveRecord::Migration
  def change
    remove_column :habits, :question
    remove_column :habits, :answer
    add_column :habits, :drinking, :string
    add_column :habits, :four_twenty, :string
    add_column :habits, :partying, :string
    add_column :habits, :overnight_visitors, :string
    add_column :habits, :music, :string
  end
end
