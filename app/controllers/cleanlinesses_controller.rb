# == Schema Information
#
# Table name: cleanlinesses
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  kitchen      :integer
#  bathroom     :integer
#  common_space :integer
#  user_id      :integer
#

class CleanlinessesController < ApplicationController
  before_action :authorize


  def edit
    @user = User.find(params[:user_id])
    @desired_match_trait = @user.desired_match_trait
    @action = user_cleanliness_path(@user, @user.cleanliness)
    @method = "PATCH"
    render :edit, :layout => false
  end

  def update
    @user = User.find(params[:user_id])
    cleanliness = @user.cleanliness
    desired_cleanliness = @user.desired_cleanliness

    stringified_params = desired_answer_params_to_string

    if cleanliness.update(cleanliness_params) && desired_cleanliness.update(stringified_params)
      redirect_to user_path(@user)
    else
      flash.now[:error] = cleanliness.errors.to_a + desired_cleanliness.errors.to_a
      @action = user_cleanliness_path(@user, @user.cleanliness)
      @method = "PATCH"
      render :edit
    end
  end

  def show
  end

  private

    def cleanliness_params
      params.require(:user).permit(:cleanliness_attributes =>[:kitchen, :bathroom, :common_space])[:cleanliness_attributes]
    end

    def desired_cleanliness_params
      params.require(:user).permit![:desired_cleanliness_attributes]
    end

    def desired_answer_params_to_string
      question_columns = Cleanliness.user_input_columns
      question_columns.each do |question|
        if desired_cleanliness_params[question]
          desired_cleanliness_params[question] = desired_cleanliness_params[question].join
        end
      end
      desired_cleanliness_params
    end

end
