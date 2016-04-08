class ChangeColumnsOnCleanliness < ActiveRecord::Migration
  def change
    remove_column :cleanlinesses, :question
    remove_column :cleanlinesses, :answer
    add_column :cleanlinesses, :kitchen, :string
    add_column :cleanlinesses, :bathroom, :string
    add_column :cleanlinesses, :common_space, :string
  end
end
