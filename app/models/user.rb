# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string
#  email         :string
#  age           :integer
#  gender        :string
#  dealbreakers  :text
#  has_apartment :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
 has_one :preference
 has_one :profile
end
