# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
<<<<<<< HEAD
#  age             :datetime
=======
#  birthdate       :datetime
>>>>>>> birthdate
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
 include UserMatchifiable::MatchQuantifiable
 include UserMatchifiable::MatchBy

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

<<<<<<< HEAD
 validates_presence_of :email, :username, :name, :age, :gender

 #validates_uniqueness_of :email, :username

=======
 validates_presence_of :email, :username, :name, :birthdate, :gender
 # validates_uniqueness_of :email, :username
>>>>>>> birthdate
 validates_presence_of :password, on: :create
 validates_confirmation_of :password
 validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
 validates_inclusion_of :gender, :in => %w( M F )
 validates :max_rent, {:numericality => { :greater_than_or_equal_to => 0 }, :on => :update, :if => Proc.new {|c| not c.max_rent.blank?}}

  def convert_age
    now = Time.now.utc.to_date
    now.year - self.age.year - (self.age.to_date.change(:year => now.year) > now ? 1 : 0)
  end


after_create :create_category_objects



def convert_age
  now = Time.now.utc.to_date
   now.year - self.birthdate.year - (self.birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
end


  def profile_percent_complete
   completion_hash = User.user_columns.each_with_object({completed: 0, total: 0}) do |col, num_questions|
     num_questions[:total] += 1
     num_questions[:completed] += 1 if self.send(col)
  end

   completion_hash = User.question_tables.each_with_object(completion_hash) do |category, num_questions|
      Object.const_get(category.classify).user_input_columns.each do |col|
        num_questions[:total] += 1
        num_questions[:completed] += 1 if self.send(category.singularize).send(col)
      end
   end

   ((completion_hash[:completed]/completion_hash[:total].to_f) * 100).to_i
 end

 def create_category_objects
   User.question_tables.each { |table| self.send("create_#{table.singularize}") }
 end

 private

   def self.question_tables
     ActiveRecord::Base.connection.tables.reject { |t| ["users", "match_connections", "schema_migrations"].include?(t) }
   end

   def self.user_columns
     self.column_names.reject { |col| ["id", "name", "username", "email", "password_digest", "created_at", "updated_at"].include?(col) }
   end

end
