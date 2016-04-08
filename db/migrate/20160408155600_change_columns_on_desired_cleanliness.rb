class ChangeColumnsOnDesiredCleanliness < ActiveRecord::Migration
  def change
    remove_column :desired_cleanlinesses, :question
    remove_column :desired_cleanlinesses, :answer
    add_column :desired_cleanlinesses, :kitchen, :string
    add_column :desired_cleanlinesses, :bathroom, :string
    add_column :desired_cleanlinesses, :common_space, :string
  end
end
