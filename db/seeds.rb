# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 500 users with default City of New York
500.times do
  FactoryGirl.create :user
end

# 500 users with seeking roommates in Rancho Cucamonga
500.times do
  user = FactoryGirl.create :user
  user.desired_match_trait.city = "Rancho Cucamonga"
  user.save
end

# Profile Pics
# ============
profile_pics = (1..15).to_a.map do |n|
  "db/profile_pics/user#{n}.jpg"
end

5.times do 
  profile_pics.push("db/profile_pics/blank_user.png")
end

all_users = User.all.shuffle
all_users.each do |user|
  user.photo = File.new(profile_pics.sample)
  user.save
end


# Cleanliness
# ===========

#   clean users (240)
#     clean seeking clean (150)
#     clean seeking average (90)
#   dirty users (240)
#      dirty seeking dirty (150)
#      dirty seeking average (90)
#   average users (520)
#      average seeking average (300)
#      average seeking clean (220)

all_users = User.all.shuffle
# 2-i dont cares; 5-a little important; 10-somewhat important; 5-very important
importances = [1,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4]

# clean users
# -----------
clean_users = all_users.pop(240)

clean_users.each do |user|
  user.cleanliness.kitchen = [4,4,5].sample
  user.cleanliness.bathroom = [4,4,5].sample
  user.cleanliness.common_space = [4,4,5].sample
  user.save
end

# clean users seeking clean users
clean_users.pop(150).each do |user|
  user.desired_cleanliness.kitchen = ["4","4","5"].sample(rand(2..3)).join
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = ["4","4","5"].sample(rand(2..3)).join
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = ["4","4","5"].sample(rand(2..3)).join
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

#clean users seeking average
clean_users.pop(90).each do |user|
  user.desired_cleanliness.kitchen = ["2","3"].sample(rand(2..3)).join
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = ["2","3"].sample(rand(2..3)).join
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = ["2","3"].sample(rand(2..3)).join
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# dirty users
# -----------
dirty_users = all_users.pop(240)

dirty_users.each do |user|
  user.cleanliness.kitchen = [1,1,2,2,2].sample
  user.cleanliness.bathroom = [1,1,2,2,2].sample
  user.cleanliness.common_space = [1,1,2,2,2].sample
  user.save
end

# dirty users seeking dirty users
dirty_users.pop(150).each do |user|
  user.desired_cleanliness.kitchen = ["1","1","2","2","2"].sample(rand(2..3)).join
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = ["1","1","2","2","2"].sample(rand(2..3)).join
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = ["1","1","2","2","2"].sample(rand(2..3)).join
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# dirty users seeking average
dirty_users.pop(90).each do |user|
  user.desired_cleanliness.kitchen = ["2","3","3","3","3","4"].sample(rand(2..3)).join
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = ["2","3","3","3","3","4"].sample(rand(2..3)).join
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = ["2","3","3","3","3","4"].sample(rand(2..3)).join
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# averagely clean
# ---------------
averagely_clean_users = all_users.pop(520)

averagely_clean_users.each do |user|
  user.cleanliness.kitchen = [2,3,3,3,3,4].sample
  user.cleanliness.bathroom = [2,3,3,3,3,4].sample
  user.cleanliness.common_space = [2,3,3,3,3,4].sample
  user.save
end

# averagely clean seeking averagely clean
averagely_clean_users.pop(300).each do |user|
  user.desired_cleanliness.kitchen = ["2","3","3","3","3","4"].sample(rand(2..3)).join
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = ["2","3","3","3","3","4"].sample(rand(2..3)).join
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = ["2","3","3","3","3","4"].sample(rand(2..3)).join
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# averagely clean seeking clean
averagely_clean_users.pop(220).each do |user|
  user.desired_cleanliness.kitchen = ["3","3","4","4","4","4","5","5"].sample(rand(2..3)).join
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = ["3","3","4","4","4","4","5","5"].sample(rand(2..3)).join
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = ["3","3","4","4","4","4","5","5"].sample(rand(2..3)).join
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# Schedule
# ========

all_users = User.all.shuffle
# 2-i dont cares; 5-a little important; 10-somewhat important; 5-very important
# importances = [1,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4]

# work & sleep
# ------------

# unemployed/freelance seeking unemployed/freelance
subset = all_users.pop(150)
    # sleep responsible seeking responsible
    subset.pop(50).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = "12"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = "12"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep responsible seeking nocturnal or day
    subset.pop(25).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = "12"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = "34"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep late seeking responsible or late
    subset.pop(50).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work_importance = importances.sample
      user.desired_schedule.work = "12"
      user.schedule.sleep = 2
      user.desired_schedule.sleep = "12"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep nocturnal or day seeking anything but nocturnal or day
    subset.pop(25).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = "12"
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = ["1","1","2","2","5"].sample(rand(2..3)).join
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end

# unemployed/freelance seeking 9-5 or graveyard or workaholic
subset = all_users.pop(150)
    # sleep responsible seeking responsible
    subset.pop(50).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = ["3","3","4","4","5"].sample(rand(2..3)).join
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = "1"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep responsible seeking nocturnal or day
    subset.pop(25).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = ["3","3","4","4","5"].sample(rand(2..3)).join
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = "34"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep late seeking responsible or late
    subset.pop(50).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = ["3","3","4","4","5"].sample(rand(2..3)).join
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 2
      user.desired_schedule.sleep = "12"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep nocturnal or day seeking anything but nocturnal or day
    subset.pop(25).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = ["3","3","4","4","5"].sample(rand(2..3)).join
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = ["1","1","2","2","5"].sample(rand(2..3)).join
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end

# 9-5 seeking 9-5
subset = all_users.pop(350)
    # sleep responsible seeking responsible
    subset.pop(250).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = "3"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = "1"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep responsible doesnt care
    subset.pop(100).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = "3"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = ["1","2","3","4","5"].sample(rand(2..3)).join
      user.desired_schedule.sleep_importance = 1
      user.save
    end

# 9-5 seeking graveyard or workaholic
subset = all_users.pop(150)
    # sleep responsible seeking day or nocturnal
    subset.pop(100).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = "45"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = "34"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep responsible doesnt care
    subset.pop(50).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = "45"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = ["1","2","3","4","5"].sample(rand(2..3)).join
      user.desired_schedule.sleep_importance = 1
      user.save
    end

# graveyard seeking 9-5 or workaholic
subset = all_users.pop(100)
    # sleep nocturnal or day seeking responsible
    subset.pop(60).each do |user|
      user.schedule.work = 4
      user.desired_schedule.work = "35"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = "1"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep nocturnal or day doesnt care
    subset.pop(40).each do |user|
      user.schedule.work = 4
      user.desired_schedule.work = "35"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = ["1","2","3","4","5"].sample(rand(2..3)).join
      user.desired_schedule.sleep_importance = 1
      user.save
    end

# workaholic seeking freelance or 9-5
subset = all_users.pop(100)
    # sleep responsible or late seeking responsible or late
    subset.pop(70).each do |user|
      user.schedule.work = 5
      user.desired_schedule.work = "23"
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = "12"
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep never seeking never
    subset.pop(30).each do |user|
      user.schedule.work = 5
      user.desired_schedule.work = "23"
      user.desired_schedule.work_importance = importances.sample
      user.desired_schedule.sleep = "5"
      user.desired_schedule.sleep_importance = importances.sample
      user.schedule.sleep = 5
      user.save
    end

# bathroom schedule
# -----------------
all_users = User.all.shuffle
# 2-i dont cares; 5-a little important; 10-somewhat important; 5-very important
# importances = [1,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4]


# before 6 seeking anything else
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 1
  user.desired_schedule.bathroom = ["2","3","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = importances.sample
  user.save
end
# before 6 doesnt care
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 1
  user.desired_schedule.bathroom = ["1","2","3","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = 1
  user.save
end

# 6-7 seeking anything else
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 2
  user.desired_schedule.bathroom = ["1","3","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = importances.sample
  user.save
end

# 6-7 doesnt care
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 2
  user.desired_schedule.bathroom = ["1","2","3","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = [1,1,2].sample
  user.save
end

# 7-8 seeking anything else
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 3
  user.desired_schedule.bathroom = ["1","2","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = importances.sample
  user.save
end

# 7-8 doesnt care
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 3
  user.desired_schedule.bathroom = ["1","2","3","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = [1,1,2].sample
  user.save
end

# 8-10 seeking anything else
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 4
  user.desired_schedule.bathroom = ["1","2","3","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = importances.sample
  user.save
end

# 8-10 doesnt care
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 4
  user.desired_schedule.bathroom = ["1","2","3","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = [1,1,2].sample
  user.save
end

# later seeking anything else
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 5
  user.desired_schedule.bathroom = ["1","2","3","4"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = [1,1,2].sample
  user.save
end

# later doesnt care
subset = all_users.pop(100).each do |user|
  user.schedule.bathroom = 5
  user.desired_schedule.bathroom = ["1","2","3","4","5"].sample(rand(2..3)).join
  user.desired_schedule.bathroom_importance = [1,1,2].sample
  user.save
end

# kitchen
# -------
# still random
all_users = User.all.shuffle
all_users.each do |user|
  user.schedule.kitchen = [1,2,3,4,5].sample
  user.desired_schedule.kitchen = ["1","2","3","4","5"].sample
  user.desired_schedule.kitchen_importance = [1,2,3,4].sample
  user.save
end

DesiredSchedule.where(work: nil). each do |des_sched_obj|
  des_sched_obj.delete
end

Schedule.where(work: nil). each do |sched_obj|
  sched_obj.delete
end

DesiredHabit.where(drinking: nil). each do |des_habit_obj|
  des_habit_obj.delete
end

Habit.where(drinking: nil). each do |habit_obj|
  habit_obj.delete
end
