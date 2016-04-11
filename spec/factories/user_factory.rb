# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  birthdate       :datetime
#  gender          :string
#  dealbreakers    :text
#  has_apartment   :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  username        :string
#  max_rent        :integer
#

FactoryGirl.define do

 factory :user do
    name { Faker::Name.name }
    age { Faker::Date.between(60.years.ago, 18.years.ago)}
    gender { ["M", "F"].sample }
    sequence (:email) {|n| "user#{n}@example.com" }
    sequence (:username) { |n| "user#{n}" }
    password { "123" }
    max_rent 100

    trait :with_cleanliness do
      cleanliness factory: :cleanliness
      desired_cleanliness factory: :desired_cleanliness
    end

    trait :with_schedule do
      schedule factory: :schedule
      desired_schedule factory: :desired_schedule
    end

    trait :with_habit do
      habit factory: :habit
      desired_habit factory: :desired_habit
    end

    factory :complete_user do
      cleanliness factory: :cleanliness
      desired_cleanliness factory: :desired_cleanliness
      schedule factory: :schedule
      desired_schedule factory: :desired_schedule
      habit factory: :habit
      desired_habit factory: :desired_habit
    end


    factory :middle_of_road_user do
      cleanliness factory: :cleanliness
      desired_cleanliness factory: :desired_cleanliness
      schedule factory: :schedule
      desired_schedule factory: :desired_schedule
      habit factory: :habit
      desired_habit factory: :desired_habit
    end

    trait :is_clean_and_wants_clean do
      cleanliness factory: :is_clean
      desired_cleanliness factory: :wants_clean
    end

    trait :is_dirty_and_doesnt_care do
      cleanliness factory: :is_dirty
      desired_cleanliness factory: :doesnt_care
    end


  end


  factory :cleanliness do

    kitchen { rand(1..5)}
    bathroom { rand(1..5)}
    common_space { rand(1..5)}

    factory :is_clean do
      kitchen { rand(4..5)}
      bathroom { rand(4..5)}
      common_space { rand(4..5)}
    end

    factory :is_dirty do
      kitchen { rand(1..2)}
      bathroom { rand(1..2)}
      common_space { rand(1..2)}
    end

    factory :middle_of_road do
      kitchen { [2,3,3,4]}
      bathroom { rand(1..5)}
      common_space { rand(1..5)}
    end
  end

  factory :desired_cleanliness do
    kitchen { rand(1..5)}
    kitchen_importance { rand(1..4)}
    bathroom { rand(1..5)}
    bathroom_importance { rand(1..4)}
    common_space { rand(1..5)}
    common_space_importance  { rand(1..4)}

    factory :wants_clean do
      kitchen { rand(4..5)}
      kitchen_importance { rand(3..4)}
      bathroom { rand(4..5)}
      bathroom_importance { rand(3..4)}
      common_space { rand(4..5)}
      common_space_importance  { rand(3..4)}
    end

    factory :doesnt_care do
      kitchen_importance 1
      bathroom_importance 1
      common_space_importance 1
    end
  end


  factory :schedule do
    kitchen { rand(1..5)}
    bathroom { rand(1..5)}
    work { rand(1..5)}
    sleep { rand(1..5)}
  end

  factory :desired_schedule do
    kitchen { rand(1..5)}
    kitchen_importance { rand(1..4)}
    bathroom { rand(1..5)}
    bathroom_importance { rand(1..4)}
    work { rand(1..5)}
    work_importance  { rand(1..4)}
    sleep { rand(1..5)}
    sleep_importance  { rand(1..4)}
  end


  factory :habit do
    drinking { rand(1..5)}
    four_twenty { rand(1..5)}
    partying { rand(1..5)}
    overnight_visitors { rand(1..5)}
    music { rand(1..5)}
  end

  factory :desired_habit do
    drinking { rand(1..5)}
    drinking_importance { rand(1..4)}
    four_twenty { rand(1..5)}
    four_twenty_importance { rand(1..4)}
    partying { rand(1..5)}
    partying_importance  { rand(1..4)}
    overnight_visitors { rand(1..5)}
    overnight_visitors_importance  { rand(1..4)}
    music { rand(1..5)}
    music_importance  { rand(1..4)}
  end

end

