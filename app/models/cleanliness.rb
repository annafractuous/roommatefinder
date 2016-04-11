# == Schema Information
#
# Table name: cleanlinesses
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  kitchen      :integer
#  bathroom     :integer
#  common_space :integer
#  user_id      :integer
#

class Cleanliness < ActiveRecord::Base
  include ChoicesQuantifiable::Cleanliness
  include Validatable
  include UserMatchifiable
  extend InputColumnable
  belongs_to :user

  def self.user_columns
       self.column_names.reject { |col| ["id", "user_id", "created_at", "updated_at"].include?(col) }
  end
end

#Hoarder
#Controlled Mess
#Average
#Above Average
#Pristine
