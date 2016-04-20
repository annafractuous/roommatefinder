class ChangeColumnsOnDesiredCleanliness < ActiveRecord::Migration
  def change
    remove_column :desired_cleanlinesses, :question
    remove_column :desired_cleanlinesses, :answer
    add_column :desired_cleanlinesses, :kitchen, :integer
    add_column :desired_cleanlinesses, :bathroom, :integer
    add_column :desired_cleanlinesses, :common_space, :integer
  end
end
