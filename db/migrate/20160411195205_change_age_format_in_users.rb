class ChangeAgeFormatInUsers < ActiveRecord::Migration
  def change
    change_column :users, :age, :date
  end
end
