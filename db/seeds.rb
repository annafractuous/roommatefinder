# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# 100 users with default City of New York
100.times do
  FactoryGirl.create :user
end

# 100 users with seeking roommates in Rancho Cucamonga
100.times do
  user = FactoryGirl.create :user
  user.desired_match_trait.city = "Rancho Cucamonga"
end

# Cleanliness
# ===========

all_users = User.all.shuffle
# 2-i dont cares 5-a little important 10-somewhat important 5-very important
importances = [1,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4]

# clean users
# -----------
clean_users = all_users.pop(50)

clean_users.each do |user|
  user.cleanliness.kitchen = [4,4,5].sample
  user.cleanliness.bathroom = [4,4,5].sample
  user.cleanliness.common_space = [4,4,5].sample
end

# clean users seeking clean users
clean_users.pop(25).each do |user|
  user.desired_cleanliness.kitchen = [4,4,5].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [4,4,5].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [4,4,5].sample
  user.desired_cleanliness.common_space_importance = importances.sample
end

#clean users seeking average
clean_users.pop(25).each do |user|
  user.desired_cleanliness.kitchen = [2,3].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [2,3].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [2,3].sample
  user.desired_cleanliness.common_space_importance = importances.sample
end

# dirty users
# -----------
dirty_users = all_users.pop(50)

dirty_users.each do |user|
  user.cleanliness.kitchen = [1,1,2,2,2].sample
  user.cleanliness.bathroom = [1,1,2,2,2].sample
  user.cleanliness.common_space = [1,1,2,2,2].sample
end

# dirty users seeking dirty users
dirty_users.first(25).each do |user|
  user.desired_cleanliness.kitchen = [1,1,2,2,2].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [1,1,2,2,2].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [1,1,2,2,2].sample
  user.desired_cleanliness.common_space_importance = importances.sample
end

# dirty users seeking average
dirty_users.last(25).each do |user|
  user.desired_cleanliness.kitchen = [2,3,3,3,3,4].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [2,3,3,3,3,4].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [2,3,3,3,3,4].sample
  user.desired_cleanliness.common_space_importance = importances.sample
end

# averagely clean
# ---------------
averagely_clean_users = all_users.pop(100)

averagely_clean_users.each do |user|
  user.cleanliness.kitchen = [2,3,3,3,3,4].sample
  user.cleanliness.bathroom = [2,3,3,3,3,4].sample
  user.cleanliness.common_space = [2,3,3,3,3,4].sample
end

# averagely clean seeking averagely clean
averagely_clean_users.first(50).each do |user|
  user.desired_cleanliness.kitchen = [2,3,3,3,3,4].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [2,3,3,3,3,4].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [2,3,3,3,3,4].sample
  user.desired_cleanliness.common_space_importance = importances.sample
end

# averagely clean seeking clean
averagely_clean_users.last(50).each do |user|
  user.desired_cleanliness.kitchen = [3,3,4,4,4,4,5,5].sample
  user.desired_cleanliness.kitchen_importance = importances.sample
  user.desired_cleanliness.bathroom = [3,3,4,4,4,4,5,5].sample
  user.desired_cleanliness.bathroom_importance = importances.sample
  user.desired_cleanliness.common_space = [3,3,4,4,4,4,5,5].sample
  user.desired_cleanliness.common_space_importance = importances.sample
end








