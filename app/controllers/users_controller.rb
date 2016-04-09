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

class UsersController < ApplicationController

  def new
    @user = User.new(user_params)

    if @user.save
      render :show, notice: "Welcome to Roommater!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params

  end

end
