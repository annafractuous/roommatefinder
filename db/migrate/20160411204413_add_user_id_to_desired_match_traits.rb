class AddUserIdToDesiredMatchTraits < ActiveRecord::Migration
  def change
    add_column :desired_match_traits, :user_id, :integer
  end
end
