class ChangeFormatInHabits < ActiveRecord::Migration
  def change
    change_column :habits, :drinking, :integer
    change_column :habits, :four_twenty, :integer
    change_column :habits, :partying, :integer
    change_column :habits, :overnight_visitors, :integer
    change_column :habits, :music, :integer
  end
end
