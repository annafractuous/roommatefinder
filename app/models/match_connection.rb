# == Schema Information
#
# Table name: match_connections
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  match_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  compatibility :integer
#

class MatchConnection < ActiveRecord::Base
  belongs_to :user
  belongs_to :match, :class_name => "User"
  # validations
  validates_uniqueness_of :user_id, :scope => :match_id


end
