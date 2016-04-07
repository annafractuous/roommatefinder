class CreateIWants < ActiveRecord::Migration
  def change
    create_table :i_wants do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
