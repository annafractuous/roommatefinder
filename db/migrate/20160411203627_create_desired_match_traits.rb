class CreateDesiredMatchTraits < ActiveRecord::Migration
  def change
    create_table :desired_match_traits do |t|
      t.string :gender
      t.datetime :move_in_date
      t.integer :min_age
      t.integer :max_age
      t.string :city

      t.timestamps null: false
    end
  end
end
