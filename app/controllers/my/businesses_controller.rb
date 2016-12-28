class My::BusinessesController < ApplicationController
  before_action :authenticate_user!

  def index
    @businesses = current_user.businesses(:business).page(params[:page]).per(10)
  end

end
