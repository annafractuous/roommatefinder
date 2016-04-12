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

  it "should have one desired schedule" do
    t = User.reflect_on_association(:desired_schedule)
    expect(t.macro).to equal(:has_one)
  end

  # it "matches clean users with other users who want cleanliness" do
  #   user1 = FactoryGirl.create(:complete_user, :is_clean_and_wants_clean)
  #   user2 = FactoryGirl.create(:conplete_user, :is_clean_and_wants_clean)
  #   result = user1.match_by_has_and_wants_attribute("cleanliness",user2)
  #   expect(result).to be true
  # end

  # it "does not match users who want cleanliness with dirty users" do
  #   user1 = FactoryGirl.create(:user, :with_cleanliness, :is_clean_and_wants_clean)
  #   user2 = FactoryGirl.create(:user, :with_cleanliness, :is_dirty_and_doesnt_care)
  #   result = user1.match_by_has_and_wants_attribute("cleanliness",user2)
  #   expect(result).to be false
  # end


  describe '#find_matches' do
    
    describe 'it builds the basic associations' do
      let!(:user) { create :user }
      let!(:match_for_user) { create :user }

      it 'returns an AR associations collection proxy of users' do
        expect(user.find_matches.first).to be_a(User)
      end

      it 'associates a user and match through a MatchConnection' do
        user.find_matches
        expect(user.match_connections.last.user).to eq(user)
        expect(user.match_connections.last.match).to eq(match_for_user)
      end

      it 'adds the match to the user\'s matches' do
        user.find_matches
        expect(user.matches).to include(match_for_user)
      end

   end

  describe 'matches basic compatibilty on user attributes' do

    describe '#max_rent' do
      let!(:user) { create :user, max_rent: 850 }
      let!(:seeking_too_high_rent) { create :user, max_rent: 1300 }
      let!(:seeking_acceptable_rent) { create :user, max_rent: 750 }
      let!(:slightly_over_limit) { create :user, max_rent: 900 }
      
      it 'doesnt match to users who are seeking a higher rent' do
        user.find_matches
        
        expect(user.matches).not_to include(seeking_too_high_rent)
      end

      it 'does match to users who are seeking a rent below the limit' do
        user.find_matches
        
        expect(user.matches).to include(seeking_acceptable_rent)
      end

      it 'allows a rent over the limit but within reasonable limit' do
        user.find_matches
        
        expect(user.matches).to include(slightly_over_limit)
      end
    end

    describe '#gender' do
      let!(:female_user) { create :user, gender: "F" }
      let!(:female_match) { create :user, gender: "F" }
      let!(:male_user) { create :user, gender: "M" }
      let!(:male_match) { create :user, gender: "M" }
      let!(:other_user) { create :user, gender: "Other" }
      let!(:other_match) { create :user, gender: "Other" }

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
        female_match = create :user, gender: "F"
        male_user.desired_match_trait.gender = "M"
        
        male_user.find_matches
        
        expect(male_user.matches).to include(male_match)
        expect(male_user.matches).to_not include(female_match)
      end

      it 'matches a user of either gender seeking either gender to all appropriate matches' do
        male_user.desired_match_trait.gender = "Any"
        female_user.desired_match_trait.gender = "Any"
        
        male_user.find_matches
        female_user.find_matches

        expect(male_user.matches).to include(female_match, male_match)
        expect(female_user.matches).to include(female_match, male_match)
      end

      it 'matches an "other" gender user seeking "other" gender to "other" gender matches' do
        other_user.desired_match_trait.gender = "Other"
        other_user.find_matches

        expect(other_user.matches).to include(other_match)
        expect(other_user.matches).to_not include(male_match)
      end
    end

    describe '#age' do

      let!(:younger_user) {FactoryGirl.create :user, birthdate: (Time.now - 22.years)}
      let!(:older_user) {FactoryGirl.create :user, birthdate: (Time.now - 38.years)}
      let!(:younger_match) {FactoryGirl.create :user, birthdate: (Time.now - 25.years)}
      let!(:older_match) {FactoryGirl.create :user, birthdate: (Time.now - 41.years)}

      it 'matches a user to someone in their desired age range' do
        younger_user.desired_match_trait.min_age = 18
        younger_user.desired_match_trait.max_age = 26
        younger_user.save
        younger_user.find_matches

        older_user.desired_match_trait.min_age = 35
        older_user.desired_match_trait.max_age = 45
        older_user.save
        older_user.find_matches

        expect(younger_user.matches).to include(younger_match)
        expect(older_user.matches).to include(older_match)
      end

      it 'doesnt match a user to someone outside of their desired age_range' do
        younger_user.desired_match_trait.min_age = 18
        younger_user.desired_match_trait.max_age = 26
        younger_user.save
        younger_user.find_matches

        older_user.desired_match_trait.min_age = 35
        older_user.desired_match_trait.max_age = 45
        older_user.save
        older_user.find_matches
        
        expect(younger_user.matches).to_not include(older_match)
        expect(older_user.matches).to_not include(younger_match)
      end

    end

    describe '#city' do
      let!(:new_york_user) {FactoryGirl.create :user}
      let!(:rancho_cucamonga_user) {FactoryGirl.create :user}

      let!(:new_york_match) {FactoryGirl.create :user}
      let!(:rancho_cucamonga_match) {FactoryGirl.create :user}

      let!(:nebraska_match) {FactoryGirl.create :user}


      it 'only matches users and matches seeking apt in same city' do
        new_york_user.desired_match_trait.city = "New York"
        rancho_cucamonga_user.desired_match_trait.city = "Rancho Cucamonga"

        new_york_match.desired_match_trait.city = "New York"
        rancho_cucamonga_match.desired_match_trait.city = "Rancho Cucamonga"

        nebraska_match.desired_match_trait.city = "Nebraska"

        new_york_user.save
        new_york_match.save
        rancho_cucamonga_user.save
        rancho_cucamonga_match.save
        nebraska_match.save

        new_york_user.find_matches
        rancho_cucamonga_user.find_matches
        nebraska_match.find_matches

        expect(new_york_user.matches).to include(new_york_match)
        expect(rancho_cucamonga_user.matches).to include(rancho_cucamonga_match)
        expect(new_york_user.matches).to_not include(nebraska_match, rancho_cucamonga_match)
        expect(rancho_cucamonga_user.matches).to_not include(nebraska_match, new_york_match)
      end

    end
  end
  end
end
