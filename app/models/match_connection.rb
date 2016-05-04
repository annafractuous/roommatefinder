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
  # after_create :create_inverse, unless :has_inverse?
  # after_destroy :destroy_inverses, if :has_inverse?

  validates_uniqueness_of :user_id, :scope => :match_id

  # edge case for first ever user to click find_matches
  def self.most_popular_users
    if MatchConnection.all.size > 0  && self.where(interested: true).any?
      self.where(interested: true).select(:match_id).group(:match_id).limit(3).map { |connection| connection.match}
    else
      User.all.sample(3)
    end
  end

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def inverses
    self.class.where(inverse_match_options)
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverse_match_options
    { match_id: user_id, user_id: match_id }
  end
end
