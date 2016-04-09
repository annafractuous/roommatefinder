class CreateMatchConnections < ActiveRecord::Migration
  def change
    create_table :match_connections do |t|
      t.integer :user_id
      t.integer :match_id

      t.timestamps null: false
    end
  end
end
