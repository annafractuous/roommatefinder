require 'spec_helper'

describe "User" do 
  it "is invalid without name" do 
    user1 = FactoryGirl.build(:user, name: nil)
    user2 = FactoryGirl.build(:user, name: "")
    user3 = FactoryGirl.build(:user)
    user1.valid?
    user2.valid?
    user3.valid?


    expect(user1.errors.full_messages).to include "Name can't be blank"
    expect(user2.errors.full_messages).to include "Name can't be blank"
    expect(user3.errors.full_messages).to_not include "Name can't be blank"
  end
  it "is invalid without unique username" do
    user = FactoryGirl.create(:user)
    duplicate_username = FactoryGirl.build(:user, username: user.username)
    duplicate_username.valid?
    expect(duplicate_username.errors.full_messages).to include "Username has already been taken"
  end
  it "is valid with unique username" do 
    user = FactoryGirl.build(:user)
    user.valid?
    expect(user.errors.full_messages).to_not include "User is invalid without unique username"
  end


  it "validates email format" do
    user1 = FactoryGirl.build(:user, email: "hahahanicetry")
    user1.valid?
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



  it "matches cleanly users with other users who want cleanliness" do 
    user1 = FactoryGirl.create(:user, :with_cleanliness, :is_clean_and_wants_clean)
    user2 = FactoryGirl.create(:user, :with_cleanliness, :is_clean_and_wants_clean)
    result = user1.match_by_has_and_wants_attribute("cleanliness",user2)
    expect(result).to be true
  end

  it "does not match cleanly users who want cleany with dirty users" do
    user1 = FactoryGirl.create(:user, :with_cleanliness, :is_clean_and_wants_clean)
    user2 = FactoryGirl.create(:user, :with_cleanliness, :is_dirty_and_doesnt_care)
    result = user1.match_by_has_and_wants_attribute("cleanliness",user2)
    expect(result).to be false
  end

  

  describe '#find_matches' do
    
    describe 'it builds the basic associations' do

      let (:user) { FactoryGirl.build :user }
      let (:match_for_user) { FactoryGirl.build :user }

      it 'returns an AR associations collection proxy of users' do
        expect(user.find_matches.first).to be_a(User)
      end
  
      it 'associates a user and match through a MatchConnection' do
        user.find_matches
        expect(user.match_connections.last.user).to eq(user)
        expect(user.match_connections.last.match).to eq(match_for_user)
      end
  
      it 'adds the match to the user\'s matches' do
        expect(user.matches).to include(match_for_user)
      end

   end

  describe 'matches basic compatibilty on user attributes' do

    describe '#max_rent' do
      let (:user) {FactoryGirl.create(:user, max_rent: 850 }
      let (:seeking_too_high_rent) {FactoryGirl.create(:user, max_rent: 1100)}
      let (:seeking_acceptable_rent) {FactoryGirl.create(:user, max_rent: 800)}
      let (:slightly_over_limit) {FactoryGirl.create(:user, max_rent: 900)}

      it 'doesnt match to users who are seeking a higher rent' do
        user.find_matches
        expect(user.matches).not_to include(:seeking_too_high_rent)
      end

      it 'does match to users who are seeking a rent below the limit' do
        user.find_matches
        expect(user.matches).to include(:seeking_acceptable_rent)
      end

      it 'allows a rent over the limit but within reasonable limit' do
        user.find_matches
        expect(user.matches).to include(:slightly_over_limit)
      end

    end

    describe '#gender' do
      let (:female_user) {FactoryGirl.create(:user, gender: "F")}
      let (:male_user)  {FactoryGirl.create(:user, gender: "M")}
      let (:female_match) {FactoryGirl.create(:user, gender: "F")}
      let (:male_match)  {FactoryGirl.create(:user, gender: "M")}

      it 'matches a female seeking female to females' do
        female_user.desired_match_trait.gender = "F"
        female_user.find_matches
        expect(female_user.matches).to include(female_match)
        expect(female_user.matches).to_not include(male_match)
      end

      it 'matches a female seeking a male to males' do
        female_user.desired_match_trait.gender = "M"
        female_user.find_matches
        expect(female_user.matches).to include(male_match)
        expect(female_user.matches).to_not include(female_match)
      end

      it 'matches a male seeking a female to females' do
        male_user.desired_match_trait.gender = "F"
        male_user.find_matches
        expect(male_user.matches).to include(female_match)
        expect(male_user.matches).to_not include(male_match)
      end

      it 'matches a male seeking a male to males' do
        male_user.desired_match_trait.gender = "M"
        male_user.find_matches
        expect(male_user.matches).to include(male_match)
        expect(male_user.matches).to_not include(female_match)
      end

      it 'matches a user of either gender seeking either gender to all apprpriate matches' do
        male_user.desired_match_trait.gender = "Any"
        male_user.find_matches
        expect(male_user.matches).to include(female_match)
        expect(male_user.matches).to include(male_match)

        female_user.desired_match_trait.gender = "Any"
        female_user.find_matches
        expect(female_user.matches).to include(female_match)
        expect(female_user.matches).to include(male_match)
      end


    end

    describe '#age' do
      let (:younger_user) {}
      let (:older_user) {}
      let (:younger_match) {}
      let (:older_match) {}


    end

    describe '#city' do

    end

  end

  
  end
end





