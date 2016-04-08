class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :profile_id
      t.string :question
      t.string :answer

      t.timestamps null: false
    end
  end
end
