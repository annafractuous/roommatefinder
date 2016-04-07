class RenameiWantstopreferences < ActiveRecord::Migration
  def change
    rename_table :i_wants, :preferences
  end
end
