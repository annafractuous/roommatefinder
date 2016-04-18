# == Schema Information
#
# Table name: desired_match_traits
#
#  id           :integer          not null, primary key
#  gender       :string
#  move_in_date :datetime
#  min_age      :integer
#  max_age      :integer
#  city         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

class DesiredMatchTrait < ActiveRecord::Base
  belongs_to :user
  extend ChoicesQuantifiable::Cleanliness
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable

  def print_desired_gender
    case self.gender
      when "Male"
        "male"
      when "Female"
        "female"
      when "Other"
        "of nontraditional gender"
      when "Any"
        "of any gender"
      else
        "You haven't entered a preferred gender"
    end
  end
  def convert_move_in_date
    case self.move_in_date
    when 'As soon as possible'
      DateTime.now + 14.days
    when 'Within the Month'
      DateTime.now + 30.days
    when "Within Two Months"
      DateTime.now + 2.Months
    when "Within Three Months"
      DateTime.now + 3.Months
    when "Within Six Months"
      DateTime.now + 6.Months
    else
      DateTime.now
    end
  end

  def print_move_in_date
    if self.convert_move_in_date == DateTime.now
      "Not currently seeking a roommate!"
    else
      "Seeking to move by #{self.convert_move_in_date}"
    end
  end

  ['As soon as possible', 'Within the Month', "Within Two Months", "Within Three Months", "Within Six Months", "Not Actively Seeking Roommate"]

  def print_desired_age
    if !(min_age && max_age)
      "You haven't entered a preferred age range"
    elsif min_age && !max_age
      "over the age of #{min_age}"
    elsif !min_age && max_age
      "under the age of #{max_age}"
    else
      "aged #{min_age} – #{max_age}"
    end
  end

  def print_desired_city
    if self.city
      "in #{self.city}"
    else
      "You haven't entered a city you are looking in"
    end
  end
end
