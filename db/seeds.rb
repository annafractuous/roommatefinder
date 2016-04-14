# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# 100 users with default City of New York
200.times do
  FactoryGirl.create :user
end

# 100 users with seeking roommates in Rancho Cucamonga
200.times do
  user = FactoryGirl.create :user
  user.desired_match_trait.city = "Rancho Cucamonga"
end

# Cleanliness
# ===========

all_users = User.all.shuffle
# 2-i dont cares; 5-a little important; 10-somewhat important; 5-very important
importances = [1,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4]

# clean users
# -----------
clean_users = all_users.pop(100)

clean_users.each do |user|
  user.cleanliness.kitchen = [4,4,5].sample
  user.cleanliness.bathroom = [4,4,5].sample
  user.cleanliness.common_space = [4,4,5].sample
  user.save
end

# clean users seeking clean users
clean_users.pop(50).each do |user|
  user.desired_cleanliness.kitchen = [4,4,5].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [4,4,5].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [4,4,5].sample
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

#clean users seeking average
clean_users.pop(50).each do |user|
  user.desired_cleanliness.kitchen = [2,3].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [2,3].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [2,3].sample
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# dirty users
# -----------
dirty_users = all_users.pop(100)

dirty_users.each do |user|
  user.cleanliness.kitchen = [1,1,2,2,2].sample
  user.cleanliness.bathroom = [1,1,2,2,2].sample
  user.cleanliness.common_space = [1,1,2,2,2].sample
  user.save
end

# dirty users seeking dirty users
dirty_users.pop(50).each do |user|
  user.desired_cleanliness.kitchen = [1,1,2,2,2].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [1,1,2,2,2].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [1,1,2,2,2].sample
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# dirty users seeking average
dirty_users.pop(50).each do |user|
  user.desired_cleanliness.kitchen = [2,3,3,3,3,4].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [2,3,3,3,3,4].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [2,3,3,3,3,4].sample
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# averagely clean
# ---------------
averagely_clean_users = all_users.pop(200)

averagely_clean_users.each do |user|
  user.cleanliness.kitchen = [2,3,3,3,3,4].sample
  user.cleanliness.bathroom = [2,3,3,3,3,4].sample
  user.cleanliness.common_space = [2,3,3,3,3,4].sample
  user.save
end

# averagely clean seeking averagely clean
averagely_clean_users.pop(100).each do |user|
  user.desired_cleanliness.kitchen = [2,3,3,3,3,4].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [2,3,3,3,3,4].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [2,3,3,3,3,4].sample
  user.desired_cleanliness.common_space_importance = importances.sample
  user.save
end

# averagely clean seeking clean
averagely_clean_users.pop(100).each do |user|
  user.desired_cleanliness.kitchen = [3,3,4,4,4,4,5,5].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [3,3,4,4,4,4,5,5].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [3,3,4,4,4,4,5,5].sample
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
subset = all_users.pop(25)
    # sleep responsible seeking responsible
    subset.pop(7).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = [1,2].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = 1
      user.desired_schedule.sleep_importance = importances.sample
      user.save 
    end
    # sleep responsible seeking nocturnal or day
    subset.pop(6).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = [1,2].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = [3,4].sample
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep late seeking responsible or late
    subset.pop(6).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work_importance = importances.sample
      user.desired_schedule.work = [1,2].sample
      user.schedule.sleep = 2
      user.desired_schedule.sleep = [1,1,2].sample
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep nocturnal or day seeking anything but nocturnal or day
    subset.pop(6).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = [1,2].sample
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = [1,1,2,2,5]
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
# unemployed/freelance seeking 9-5 or graveyard or workaholic
subset = all_users.pop(25)
    # sleep responsible seeking responsible
    subset.pop(7).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = [3,3,4,4,5].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = 1
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep responsible seeking nocturnal or day
    subset.pop(6).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = [3,3,4,4,5].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = [3,4].sample
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep late seeking responsible or late
    subset.pop(6).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = [3,3,4,4,5].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 2
      user.desired_schedule.sleep = [1,1,2].sample
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep nocturnal or day seeking anything but nocturnal or day
    subset.pop(6).each do |user|
      user.schedule.work = [1,2].sample
      user.desired_schedule.work = [3,3,4,4,5].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = [1,1,2,2,5]
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end

# 9-5 seeking 9-5
subset = all_users.pop(75)
    # sleep responsible seeking responsible
    subset.pop(60).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = 3
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = 1
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep responsible doesnt care
    subset.pop(15).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = 3
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = [1,2,3,4,5].sample
      user.desired_schedule.sleep_importance = 1
      user.save
    end

# 9-5 seeking graveyard or workaholic
subset = all_users.pop(25)
    # sleep responsible seeking day or nocturnal
    subset.pop(20).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = [4,5].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = [3,4].sample
      user.desired_schedule.sleep_importance = importances.sample
      user.save
    end
    # sleep responsible doesnt care
    subset.pop(5).each do |user|
      user.schedule.work = 3
      user.desired_schedule.work = [4,5].sample
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = [1,2,3,4,5].sample
      user.desired_schedule.sleep_importance = 1
      user.save
    end

# graveyard seeking 9-5 or workaholic
subset = all_users.pop(25)
    # sleep nocturnal or day seeking responsible
    subset.pop(20).each do |user|
      user.schedule.work = 4 
      user.desired_schedule.work = [3,3,5].sample
      user.desired_schedule.work_importance = importances.sample 
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = 1
      user.desired_schedule.sleep_importance = importances.sample
      user.save  
    end
    # sleep nocturnal or day doesnt care
    subset.pop(5).each do |user|
      user.schedule.work = 4 
      user.desired_schedule.work = [3,3,5].sample 
      user.desired_schedule.work_importance = importances.sample  
      user.schedule.sleep = [3,4].sample
      user.desired_schedule.sleep = [1,2,3,4,5].sample
      user.desired_schedule.sleep_importance = 1 
      user.save  
    end

# workaholic seeking freelance or 9-5
subset = all_users.pop(25)
    # sleep responsible or late seeking responsible or late
    subset.pop(10).each do |user|
      user.schedule.work = 5  
      user.desired_schedule.work = [2,3,3].sample 
      user.desired_schedule.work_importance = importances.sample
      user.schedule.sleep = 1
      user.desired_schedule.sleep = [1,1,2].sample
      user.desired_schedule.sleep_importance = importances.sample
      user.save  
    end
    # sleep never seeking never
    subset.pop(15).each do |user|
      user.schedule.work = 5  
      user.desired_schedule.work = [2,3,3].sample 
      user.desired_schedule.work_importance = importances.sample
      user.desired_schedule.sleep = 5
      user.desired_schedule.sleep_importance = importances.sample
      user.schedule.sleep = 5
      user.save  
    end









