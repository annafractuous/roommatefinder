# == Schema Information
#
# Table name: desired_match_traits
#
#  id           :integer          not null, primary key
#  gender       :string
#  move_in_date :datetime
#  min_age      :integer
#  max_age      :integer
#  city         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

class DesiredMatchTraitsController < ApplicationController
  before_action :authorize, only: [:edit, :update]

  def edit
    @user = User.find(params[:user_id])
    @desired_match_trait = @user.desired_match_trait
    @interested_matches = @user.interested_matches if @user.interested_matches.size > 0
    @action = user_desired_match_trait_path(@user, @user.desired_match_trait)
    @method = "PATCH"
  end

  def update
    @user = User.find(params[:user_id])
    desired_match_trait = @user.desired_match_trait

    if @user.update(extra_params) && desired_match_trait.update(desired_match_params)
      redirect_to user_path(@user)
    else
      flash.now[:error] = @user.errors.to_a + desired_match_trait.errors.to_a
      @action = user_desired_match_trait_path(@user, desired_match_trait)
      @method = "PATCH"
      render :edit
    end
  end

  def show
  end

private

    def extra_params
      params.require(:user).permit(:dealbreakers, :max_rent, :has_apartment)
    end

    def desired_match_params
      params.require(:user).permit(:desired_match_trait_attributes => [:gender, :move_in_date, :min_age, :max_age, :city])[:desired_match_trait_attributes]
    end

end
