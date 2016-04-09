class ChangeKitchenFormatInCleanlinesses < ActiveRecord::Migration
  def change
    change_column :cleanlinesses, :kitchen, :integer
    change_column :cleanlinesses, :bathroom, :integer
    change_column :cleanlinesses, :common_space, :integer
  end
  
end
