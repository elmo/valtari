class My::FollowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_other_user, only: [:create, :destroy]

  def index
  end

  def create
    respond_to do |format|
      if current_user.follow(@other_user)
        format.html { redirect_back(fallback_location: my_followings_path) }
        format.js
      else
        format.html {render :new}
        format.js
      end
    end
  end

  def destroy
    current_user.unfollow(@other_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: my_followings_path) }
      format.js
    end
  end

  private

  def set_other_user
    @other_user = User.find(params[:id]) if params[:id].present?
  end

end
