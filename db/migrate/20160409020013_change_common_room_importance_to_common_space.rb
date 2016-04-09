class ChangeCommonRoomImportanceToCommonSpace < ActiveRecord::Migration
  def change
    rename_column :desired_cleanlinesses, :common_room_importance, :common_space_importance
  end
end
