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
  extend ChoicesQuantifiable::Cleanliness
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable

  belongs_to :user

  def convert_cleanliness(match_cleanliness)
    cleanliness_hash = Cleanliness.user_input_columns.each_with_object({}) do |col,hash|
    hash[col] = Cleanliness.cleanliness_quantified[match_cleanliness.send(col)]
    end
    cleanliness_hash
  end

  def self.print_category_score(user, match)
    score = MatchCalculation.mutual_compatibility_score_per_category(user, match, self.name.downcase)
    if score == -1
      "One of you hasn't answered any questions in this category"
    else
      "You are #{score}% compatible in this category!"
    end
  end

end
