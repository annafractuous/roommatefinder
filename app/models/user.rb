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

  has_attached_file :photo, styles: { small: "200x200"}
  validates_attachment_content_type :photo, content_type: /\Aimage/
  validates_attachment_file_name :photo, matches: [/png\Z/, /jpe?g\Z/]

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
  validates_inclusion_of :gender, :in => %w( Male Female Other)
  validates :max_rent, {:numericality => { :greater_than_or_equal_to => 0 }, :on => :update, :if => Proc.new {|c| not c.max_rent.blank?}}

  after_create :create_category_objects, :assign_blank_profile_pic

  ## slug URL ##
  def to_param
    "#{id}-#{username.downcase}"
  end

  ## assign a new user a blank profile picture ##
  def assign_blank_profile_pic
    self.photo = File.new("app/assets/images/blank_user.png")
    self.save
  end

  ## display name as first name and 1st initial of last name ##
  def display_name
    name = self.name.split
    last_initial = name.last[0] + "."
    "#{name.first} #{last_initial}"
  end

  ## get age from birthdate ##
  def convert_age
    now = Time.now.utc.to_date
    now.year - self.birthdate.year - (self.birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  ## show user others who selected that they were interested in a potential roommate match with them ##
  def interested_matches
    # weed out mutually interested
    connections = MatchConnection.where('match_id = ? AND interested = ?', self.id, true)
    #reject mutually interested matches
    connected_users = connections.map { |connection| User.find(connection.user_id) }
  end

  def one_way_interested_matches 
    connected_users = self.interested_matches
    connected_users.reject{|user| self.mutually_interested_match?(user)}
  end

  def not_interested
    no_thanks = MatchConnection.where('user_id = ? AND interested = ?', self.id, false)
    no_thanks.map { |conn| User.find(conn.match_id) }
  end

  def mutually_interested_matches
    self.interested_matches.select { |m| self.mutually_interested_match?(m) }
  end

  def mutually_interested_match?(match)
    self.is_interested(match) && match.is_interested(self)
  end

  def is_interested(match)
    self.match_connection_object_for(match).interested == true
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

  ## get the MatchConnection object for a match between two users ##
  def match_connection_object_for(match)
    self.match_connections.where(match: match)[0]
  end

  ## get two users' compatibility score ##
  def compatibility_with(match)
    self.match_connection_object_for(match).compatibility
  end

 ############################# MATCHING ALGORITHMS #############################

  def find_matches
    set = User.where.not(id: self.id)

    set = self.reject_wrong_gender(set) if self.desired_match_trait.gender
    set = self.reject_wrong_rent(set) if self.max_rent
    set = self.reject_wrong_age(set) if self.desired_match_trait.min_age && self.desired_match_trait.max_age
    set = self.reject_wrong_city(set) if self.desired_match_trait.city
    set = self.reject_wrong_move_in_date(set) if self.desired_match_trait[:move_in_date]

    set.each do |match|
      run_match_calculations(match)
    end

    self.matches
  end

  ## had to break this into another method because needs to be run
  ## on a single match in match_connections_controller when one
  ## user selects interst in another
  def run_match_calculations(match)
    category_compat_scores = all_category_compatibility_scores(match) # => [63, 45, 87]
    category_compat_scores = blank_category_sanitizer(category_compat_scores)
    compatibility_score = self.calculate_compatibility_score(category_compat_scores)

    connection = self.match_connections.find_or_create_by(match: match)
    connection.compatibility = compatibility_score
    connection.save
  end

  ## calculate total mutual compatibility ##
  def calculate_compatibility_score(category_scores)
    if category_scores.size <= 2
      score = Math.sqrt(category_scores.first * category_scores.last.to_f).to_i
      score == 0 ? 1 : score
    else
      first = category_scores.shift.to_f
      second = category_scores.shift.to_f
      score_so_far = Math.sqrt(first * second).to_i
      if score_so_far == 0
        score_so_far = 1
      end
      category_scores.unshift(score_so_far)
      calculate_compatibility_score(category_scores)
    end
  end

  ## get mutual compatibility scores for each category ##
  def all_category_compatibility_scores(match)
    categories = User.question_tables.reject { |table| table.starts_with?("desired") }
    # => ["cleanlinesses", "habits", "schedules"]
    categories.each_with_object([]) do |category, compat_scores|
      compat_scores << self.mutual_compatibility_score_per_category(category, match)
    end
  end

  ## calculate mutual compatibility for category ##
  def mutual_compatibility_score_per_category(category, match)
    user_to_match_percentage = self.compatibility_percentage_per_category(category, match)
    match_to_user_percentage = match.compatibility_percentage_per_category(category, self)

    if user_to_match_percentage == -1 || match_to_user_percentage == -1
       # -1 is a flag that the category has not been filled out at all
      return -1
    else
      compatibility = Math.sqrt(user_to_match_percentage * match_to_user_percentage).to_i
    end
  end

  ## check one-way compatibility for a single category ##
  def compatibility_percentage_per_category(category, match)
    ## weighted responses to 'how important is this to you' ##
    conversion_hash = { 1 => 0, 2 => 1, 3 => 10, 4 => 250 }

    total_possible_points = 0
    points_earned = 0

    table = Object.const_get(category.classify) # e.g. Cleanliness table

    if self.send(category.singularize).all_input_columns_nil?
      # -1 is a flag that the category has not been filled out at all
      return -1
    else
      question_columns = table.user_input_columns
      # => ["kitchen", "bathroom", "common_space"]
      question_columns.each do |attrb|
        desired_cat = "desired_#{category}".singularize

        if self.send(desired_cat).send(attrb)
          desired_answers = self.send(desired_cat).send(attrb).split('') # "45" => ["4", "5"]
          importance = self.send(desired_cat).send("#{attrb}_importance")
          points = conversion_hash[importance]
          total_possible_points += points

          answer = match.send(category.singularize).send(attrb)
          points_earned += points if desired_answers.include?(answer.to_s)
        end
      end
      total_possible_points != 0 ? (points_earned / total_possible_points.to_f * 100).to_i : 1
    end
  end

  # give scores a penalty if no questions are filled out in a category.
  # resolves issue of a blank score dragging down all other scores
  def blank_category_sanitizer(scores_array)
    scores_array.reject! { |score| score == -1 }
    if scores_array.size == 0
      scores_array = [1]
      scores_array
    elsif scores_array.size <= 2
      # penalty applied to score if you havent filled out all categories
      scores_array.map { |score| (score * 0.33).to_i}
    else
      scores_array
    end

  end

  def reject_wrong_rent(set)
    max_rent_with_cushion = self.max_rent + 200
    set.where("max_rent <= ?", max_rent_with_cushion)
  end

  def reject_wrong_gender(set)
    your_gender = self.desired_match_trait.gender
    your_gender == "Any" ? set : set.where("users.gender = ?", your_gender)
  end


  def reject_wrong_age(set)
    min_birth_year = DateTime.now - (self.desired_match_trait.min_age.years - 1.years)
    max_birth_year =  DateTime.now - (self.desired_match_trait.max_age.years + 1.years)
    set.where("birthdate < ? AND birthdate > ?",min_birth_year, max_birth_year)
  end

  def reject_wrong_city(set)
    set.joins(:desired_match_trait).where("desired_match_traits.city = ?", self.desired_match_trait.city)
  end

  def reject_wrong_move_in_date(set)
    min_date = desired_match_trait[:move_in_date] - 61.days
    max_date = desired_match_trait[:move_in_date] + 61.days
    set.joins(:desired_match_trait).where("desired_match_traits.move_in_date > ? AND desired_match_traits.move_in_date < ?", min_date, max_date)
  end

 private

   def self.question_tables
     ActiveRecord::Base.connection.tables.reject { |t| ["users", "match_connections", "schema_migrations"].include?(t) }
   end

   def self.user_columns
     self.column_names.reject { |col| ["id", "name", "username", "email", "password_digest", "created_at", "updated_at"].include?(col) }
   end

end
