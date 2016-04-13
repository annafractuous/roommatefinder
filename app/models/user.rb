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

class User < ActiveRecord::Base

  has_secure_password

  has_one :cleanliness
  has_one :desired_cleanliness
  has_one :schedule
  has_one :desired_schedule
  has_one :habit
  has_one :desired_habit
  has_one :desired_match_trait
  has_many :match_connections
  has_many :matches, through: :match_connections

  accepts_nested_attributes_for :habit, :desired_habit
  accepts_nested_attributes_for :cleanliness, :desired_cleanliness
  accepts_nested_attributes_for :schedule, :desired_schedule
  accepts_nested_attributes_for :desired_match_trait

  validates_presence_of :email, :username, :name, :birthdate, :gender
  validates_uniqueness_of :email, :username
  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_inclusion_of :gender, :in => %w( M F Other)
  validates :max_rent, {:numericality => { :greater_than_or_equal_to => 0 }, :on => :update, :if => Proc.new {|c| not c.max_rent.blank?}}

  after_create :create_category_objects

  ## slug URL ##
  def to_param
    "#{id}-#{username.downcase}"
  end

  ## get age from birthdate ##
  def convert_age
    now = Time.now.utc.to_date
     now.year - self.birthdate.year - (self.birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  ## build user's associated cleanliness, desired cleanliness, etc. on user initialization ##
  def create_category_objects
    User.question_tables.each { |table| self.send("create_#{table.singularize}") }
  end

  ## calculate percentage of profile that's complete ##
  def profile_percent_complete
    ## questions completed on user model (e.g. max rent, etc.) ##
    completion_hash = User.user_columns.each_with_object({completed: 0, total: 0}) do |col, num_questions|
     num_questions[:total] += 1
     num_questions[:completed] += 1 if self.send(col)
    end

    ## questions completed on all other models (e.g. cleanliness, desired_cleanliness, etc.) ##
    completion_hash = User.question_tables.each_with_object(completion_hash) do |category, num_questions|
      Object.const_get(category.classify).user_input_columns.each do |col|
        num_questions[:total] += 1
        num_questions[:completed] += 1 if self.send(category.singularize).send(col)
      end
    end

   ((completion_hash[:completed]/completion_hash[:total].to_f) * 100).to_i
  end

 ## MATCHING ALGORITHMS ##

  ## check one-way compatibility between user and match for a single category ##
  def compatibility_percentage_per_category(category, match)
    ## weighted responses to 'how important is this to you' ##
    conversion_hash = { 1 => 0, 2 => 1, 3 => 10, 4 => 50 }

    total_possible_points = 0
    points_earned = 0

    table = Object.const_get(category.classify) # e.g. Cleanliness table
    question_columns = table.user_input_columns
    # => ["kitchen", "bathroom", "common_space"]

    question_columns.each do |attrb| # e.g. attrb = "kitchen"
      desired_cat = "desired_#{category}".singularize # desired_cleanliness
      desired_answer = self.send(desired_cat).send(attrb) # => "Presentable"
      importance = self.send(desired_cat).send("#{attrb}_importance") # e.g. "kitchen_importance" => 3

      points = conversion_hash[importance] # => e.g. 10
      total_possible_points += points

      answer = match.send(category.singularize).send(attrb) # => "Average"
      points_earned += points if answer == desired_answer
    end

    total_possible_points != 0 ? (points_earned / total_possible_points.to_f * 100).to_i : 0
  end

 ## calculate mutual compatibility for category ##
  def mutual_compatabilty_percentage_per_category(category, match)
    user_to_match_percentage = self.compatibility_percentage_per_category(category, match)
    match_to_user_percentage = match.compatibility_percentage_per_category(category, self)

    compatibility = Math.sqrt(user_to_match_percentage * match_to_user_percentage).to_i
  end

  ## get all mutual compatibility scores ##
  def all_category_compatibility_scores(match)
    categories = User.question_tables.reject { |table| table.starts_with?("desired") }
    # => ["cleanlinesses", "habits", "schedules"]
    categories.each_with_object([]) do |category, compat_scores|
      unless self.send(category.singularize).all_input_columns_nil?
        compat_scores << self.mutual_compatabilty_percentage_per_category(category, match)
      end
    end
  end

  ## calculate total mutual compatibility ##
  def calculate_compatibility_score(category_scores)
    if category_scores.size == 2
      return Math.sqrt(category_scores.first * category_scores.last.to_f).to_i
    else
      first = category_scores.shift.to_f
      second = category_scores.shift.to_f
      category_scores.unshift(Math.sqrt(first * second))
      calculate_compatibility_score(category_scores)
    end
  end

  def find_matches
    set = User.all.where.not(id: self.id)
    set = self.reject_wrong_gender(set) if self.desired_match_trait.gender
    set = self.reject_wrong_rent(set) if self.max_rent
    set = self.reject_wrong_age(set) if self.desired_match_trait.min_age && self.desired_match_trait.max_age
    set = self.reject_wrong_city(set) if self.desired_match_trait.city
    set = self.reject_wrong_move_in_date(set) if self.desired_match_trait.move_in_date

    set.each do |match|
      category_compat_scores = all_category_compatibility_scores(match) # => [63, 45, 87]
      compatibility_score = self.calculate_compatibility_score(category_compat_scores)
      connection = self.match_connections.create(match: match, compatibility: compatibility_score)
    end

    self.matches
  end

 def reject_wrong_rent(set)
  set.reject do |match|
    (self.max_rent + 200) < match.max_rent if self.max_rent && match.max_rent
  end
 end

def reject_wrong_gender(set)
  set.select do |user|
    case desired_match_trait.gender
    when "M"
      user.gender == "M"
    when "F"
      user.gender == "F"
    when "Other"
      user.gender == "Other"
    else
      user
    end
  end
end

def reject_wrong_age(set)
  age_range = (self.desired_match_trait.min_age..self.desired_match_trait.max_age)
  set.select do |user|
    age_range.include?(user.convert_age)
  end
end

def reject_wrong_city(set)
  set.select do |user|
    user.desired_match_trait.city == self.desired_match_trait.city
  end
end

def reject_wrong_move_in_date(set)
  min_date = desired_match_trait.move_in_date - 60.days
  max_date = desired_match_trait.move_in_date + 60.days

  set.select do |user|
    user.desired_match_trait.move_in_date.between?(min_date, max_date)
  end
end

 private

   def self.question_tables
     ActiveRecord::Base.connection.tables.reject { |t| ["users", "match_connections", "schema_migrations"].include?(t) }
   end

   def self.user_columns
     self.column_names.reject { |col| ["id", "name", "username", "email", "password_digest", "created_at", "updated_at"].include?(col) }
   end

end
