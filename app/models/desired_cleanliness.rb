# == Schema Information
#
# Table name: desired_cleanlinesses
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  kitchen                 :integer
#  bathroom                :integer
#  common_space            :integer
#  user_id                 :integer
#  kitchen_importance      :integer
#  bathroom_importance     :integer
#  common_space_importance :integer
#

class DesiredCleanliness < ActiveRecord::Base
  include HowImportantToYouAble
  extend ChoicesQuantifiable::Cleanliness
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable
  belongs_to :user

  validate :preference_and_importance_entered?
end

#  SQL (0.3ms)  INSERT INTO "match_connections" ("match_id", "user_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["match_id", 63], ["user_id", 15], ["created_at", "2016-04-13 15:31:29.788107"], ["updated_at", "2016-04-13 15:31:29.788107"]]
#    (0.6ms)  commit transaction
#   Cleanliness Load (0.1ms)  SELECT  "cleanlinesses".* FROM "cleanlinesses" WHERE "cleanlinesses"."user_id" = ? LIMIT 1  [["user_id", 63]]
#   DesiredCleanliness Load (0.3ms)  SELECT  "desired_cleanlinesses".* FROM "desired_cleanlinesses" WHERE "desired_cleanlinesses"."user_id" = ? LIMIT 1  [["user_id", 63]]
# FloatDomainError: NaN

