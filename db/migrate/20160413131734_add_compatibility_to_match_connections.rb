class AddCompatibilityToMatchConnections < ActiveRecord::Migration
  def change
    add_column :match_connections, :compatibility, :integer
  end
end
