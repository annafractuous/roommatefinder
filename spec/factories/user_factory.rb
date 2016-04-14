
FactoryGirl.define do


 factory :user do
    name { Faker::Name.name }
    birthdate { Faker::Date.between(60.years.ago, 18.years.ago) }
    gender { ["M", "F"].sample }
    email "temp@temp.com"
    username "temp"
    password { "123" }
    max_rent { 900 }

    # to avoid nil errors our User model builds all the connections
    # as a callback after an instance is created.  Need to set up
    # the factories like this as another callback.
    # Not efficient, figure out better way if time
    after(:create) do |user|
      user.email = "user#{user.id}@example.com"
      user.username = "user#{user.id}"
      user.schedule = FactoryGirl.create :schedule
      user.desired_schedule = FactoryGirl.create :desired_schedule
      user.habit = FactoryGirl.create :habit
      user.desired_habit = FactoryGirl.create :desired_habit
      user.desired_match_trait = FactoryGirl.create :desired_match_trait
      user.save
    end


  end




  factory :cleanliness do
    kitchen { rand(1..5) }
    bathroom { rand(1..5) }
    common_space { rand(1..5) }

    # factory :is_clean do
    #   kitchen { rand(4..5) }
    #   bathroom { rand(4..5) }
    #   common_space { rand(4..5) }
    # end

    # factory :is_dirty do
    #   kitchen { rand(1..2) }
    #   bathroom { rand(1..2) }
    #   common_space { rand(1..2) }
    # end

    # factory :middle_of_road do
    #   kitchen { [2,3,3,4] }
    #   bathroom { rand(1..5) }
    #   common_space { rand(1..5) }
    # end
  end

  factory :desired_cleanliness do
    kitchen { rand(1..5) }
    kitchen_importance { rand(1..4) }
    bathroom { rand(1..5) }
    bathroom_importance { rand(1..4) }
    common_space { rand(1..5) }
    common_space_importance  { rand(1..4) }

    # factory :wants_clean do
    #   kitchen { rand(4..5) }
    #   kitchen_importance { rand(3..4) }
    #   bathroom { rand(4..5) }
    #   bathroom_importance { rand(3..4) }
    #   common_space { rand(4..5) }
    #   common_space_importance  { rand(3..4) }
    # end

    # factory :doesnt_care do
    #   kitchen_importance 1
    #   bathroom_importance 1
    #   common_space_importance 1
    # end
  end


  factory :schedule do
    kitchen { rand(1..5) }
    bathroom { rand(1..5) }
    work { rand(1..5) }
    sleep { rand(1..5) }
  end

  factory :desired_schedule do
    kitchen { rand(1..5) }
    kitchen_importance { rand(1..4) }
    bathroom { rand(1..5) }
    bathroom_importance { rand(1..4) }
    work { rand(1..5) }
    work_importance  { rand(1..4) }
    sleep { rand(1..5) }
    sleep_importance  { rand(1..4) }
  end


  factory :habit do
    drinking { rand(1..5) }
    four_twenty { rand(1..5) }
    partying { rand(1..5) }
    overnight_visitors { rand(1..5) }
    music { rand(1..5) }
  end

  factory :desired_habit do
    drinking { rand(1..5) }
    drinking_importance { rand(1..4) }
    four_twenty { rand(1..5) }
    four_twenty_importance { rand(1..4) }
    partying { rand(1..5) }
    partying_importance  { rand(1..4) }
    overnight_visitors { rand(1..5) }
    overnight_visitors_importance  { rand(1..4) }
    music { rand(1..5) }
    music_importance  { rand(1..4) }
  end



  factory :desired_match_trait do
    gender { ["F", "M", "Any"].sample }
    move_in_date { Date.today + 6.months }
    min_age { rand(18..26) }
    max_age { rand(27..49) }
    city "New York"
  end
end
