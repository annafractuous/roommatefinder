class ChangeColumnsOnCleanliness < ActiveRecord::Migration
  def change
    remove_column :cleanlinesses, :question
    remove_column :cleanlinesses, :answer
    add_column :cleanlinesses, :kitchen, :integer
    add_column :cleanlinesses, :bathroom, :integer
    add_column :cleanlinesses, :common_space, :integer
  end
end
