require 'spec_helper'

describe "User" do 
  it "is invalid without name" do 
    user1 = FactoryGirl.create(:user, name: nil)
    user2 = FactoryGirl.create(:user, name: "")
    user3 = FactoryGirl.create(:user)

    expect(user1.errors.full_messages).to include "Name can't be blank"
    expect(user2.errors.full_messages).to include "User is invalid without name"
    expect(user3.errors.full_messages).to_not include "User is invalid without name"
  end
  it "is invalid without unique username" do
    user = FactoryGirl.create(:user)
    duplicate_username = FactoryGirl.create(:user, username: user.username)
    expect(duplicate_username.errors.full_messages).to include "User is invalid without unique username"
  end
  it "is valid with unique username" do 
    user = FactoryGirl.create(:user)
    expect(user.errors.full_messages).to_not include "User is invalid without unique username"
  end


  it "validates email format" do
    user1 = FactoryGirl.create(:user, email: "hahahanicetry")
    #not working
    expect(user1.errors.full_messages).to include "Email is invalid"
  end

  

  it "should have one cleanliness" do
    t = User.reflect_on_association(:cleanliness)
    expect(t.macro).to equal(:has_one)
  end

  it "should have one desired cleanliness" do
    t = User.reflect_on_association(:desired_cleanliness)
    expect(t.macro).to equal(:has_one)
  end

  it "should have one habit" do
    t = User.reflect_on_association(:habit)
    expect(t.macro).to equal(:has_one)
  end

  it "should have one desired habit" do
    t = User.reflect_on_association(:desired_habit)
    expect(t.macro).to equal(:has_one)
  end
    it "should have one schedule" do
    t = User.reflect_on_association(:schedule)
    expect(t.macro).to equal(:has_one)
  end
   it "should have one  desired schedule" do
    t = User.reflect_on_association(:desired_schedule)
    expect(t.macro).to equal(:has_one)
  end

  it "validates email format" do
    user1 = FactoryGirl.create(:user, email: "hahahanicetry")
    #not working
    expect(user1.errors.full_messages).to include "Email is invalid"
  end

  it "matches cleanly users with other users who want cleanliness" do 
    user1 = FactoryGirl.create(:user, :with_cleanliness, :is_clean_and_wants_clean)
    user2 = FactoryGirl.create(:user, :with_cleanliness, :is_clean_and_wants_clean)
    result = user1.match_by_mutual_cleanliness(user2)
    expect(result).to be true
  end
end





