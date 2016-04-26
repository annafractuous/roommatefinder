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
    MatchCalculation.question_tables.each { |table| self.send("create_#{table.singularize}") }
  end

  ## calculate percentage of profile that's complete ##
  def profile_percent_complete
    ## questions completed on user model (e.g. max rent, etc.) ##
    completion_hash = MatchCalculation.user_columns.each_with_object({completed: 0, total: 0}) do |col, num_questions|
     num_questions[:total] += 1
     num_questions[:completed] += 1 if self.send(col)
    end

    ## questions completed on all other models (e.g. cleanliness, desired_cleanliness, etc.) ##
    completion_hash = MatchCalculation.question_tables.each_with_object(completion_hash) do |category, num_questions|
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


end
