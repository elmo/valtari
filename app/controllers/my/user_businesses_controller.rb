class My::UserBusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business

  def create
    @user_business = current_user.user_businesses.create!(business_id: @business.id)
    @business.reload
    respond_to do |format|
      if @user_business.save
        format.html {redirect_back(fallback_url: my_businesses_path) }
        format.js
      else
        format.html {render :new}
        format.js
      end
    end
  end

  def destroy
    @business.reload
    current_user.user_businesses.where(business_id: @business.id).destroy_all
    respond_to do |format|
      format.html {redirect_to my_businesses_path}
      format.js
    end
  end

  private

  def set_business
    @business = Business.find(params[:business_id]) if params[:business_id].present?
  end

end
