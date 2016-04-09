class ChangeFormatInDesiredCleanlinesses < ActiveRecord::Migration
  def change
    change_column :desired_cleanlinesses, :kitchen, :integer
    change_column :desired_cleanlinesses, :bathroom, :integer
    change_column :desired_cleanlinesses, :common_space, :integer
  end
end
