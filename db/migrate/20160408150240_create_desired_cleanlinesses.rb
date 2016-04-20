class CreateDesiredCleanlinesses < ActiveRecord::Migration
  def change
    create_table :desired_cleanlinesses do |t|
      t.integer :user_id
      t.string :question
      t.string :answer

      t.timestamps null: false
    end
  end
end
