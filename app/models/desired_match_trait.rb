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
  include ActionView::Helpers::TextHelper

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

  def move_in_date=(move_in_date)
    converted_date = case move_in_date
      when '1'
        DateTime.now + 14.days
      when '2'
        DateTime.now + 30.days
      when '3'
        DateTime.now + 2.months
      when '4'
        DateTime.now + 3.months
      when '5'
        DateTime.now + 6.months
      else
        DateTime.now + 1.year
    end
    self[:move_in_date] = converted_date
  end

  def move_in_date
    date = self[:move_in_date]
    # binding.pry
    two_weeks_from_now = DateTime.now + 14.days
    one_month_from_now = DateTime.now + 1.month
    two_months_from_now = DateTime.now + 2.months
    three_months_from_now = DateTime.now + 3.months
    six_months_from_now = DateTime.now + 6.month
    
    if date <= two_weeks_from_now
      '1'
    elsif (date > two_weeks_from_now) && (date <= one_month_from_now)
      '2'
    elsif (date > one_month_from_now) && (date <= two_months_from_now)
      '3'
    elsif (date > two_months_from_now) && (date <= three_months_from_now)
      '4'
    elsif(date > three_months_from_now) && (date <= six_months_from_now)
      '5'
    else
      '6'
    end
  end

  def print_move_in_date
    if self[:move_in_date]
      if self[:move_in_date] > (DateTime.now + 6.months)
      "Not currently seeking a roommate!"
      else
        self.convert_datetime_to_months
      end
    else
      "Not currently seeking a roommate!"
    end
  end

  def convert_datetime_to_months
    diff = ((self[:move_in_date] - DateTime.now)/1.month).round
      if diff < 1
        diff = ((self[:move_in_date] - DateTime.now)/1.week).round
        "Looking to move in #{pluralize(diff, "week")}"
      elsif diff < 7
        "Looking to move in #{pluralize(diff, "month")}"
      else
        "Not currently seeking a roommate."
      end
  end
        

    


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
