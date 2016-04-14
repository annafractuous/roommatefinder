class AddInterestedToMatchConnections < ActiveRecord::Migration
  def change
    add_column :match_connections, :interested, :boolean
  end
end
