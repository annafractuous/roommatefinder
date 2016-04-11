# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  age             :integer
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
 has_many :match_connections
 has_many :matches, through: :match_connections
 accepts_nested_attributes_for :habit, :desired_habit
 accepts_nested_attributes_for :cleanliness, :desired_cleanliness
 accepts_nested_attributes_for :schedule, :desired_schedule

 validates_presence_of :email, :username, :name, :age, :gender
 validates_uniqueness_of :email, :username
 validates_presence_of :password, on: :create
 validates_confirmation_of :password
 validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/


 def profile_percent_complete
   total_questions = 0
   questions_answered = 0

   User.user_columns.each do |col|
     total_questions += 1
     questions_answered += 1 if self.send(col) != nil
   end

   User.question_tables.each do |category|
     if self.send(category.singularize)
       User.question_columns(category).each do |col|
         total_questions += 1
         questions_answered += 1 if self.send(category.singularize).send(col) != nil
       end
     else
       total_questions += User.question_columns(category).size
     end
   end

   ((questions_answered/total_questions.to_f) * 100).to_i
 end

 private

   def self.question_tables
     ActiveRecord::Base.connection.tables.reject { |t| ["users", "match_connections", "schema_migrations"].include?(t) }
   end

   def self.user_columns
     self.column_names.reject { |col| ["id", "name", "username", "email", "password_digest", "created_at", "updated_at"].include?(col) }
   end

   def self.question_columns(table)
     table = Object.const_get(table.classify)
     table.column_names.reject { |col| ["id", "user_id", "created_at", "updated_at"].include?(col) }
   end



end
