class My::InterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_my_interests_path(@buyside) , notice: 'Your interests have successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(industry_classification_ids: [] )
  end

end
