class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:splash]

  def splash
     redirect_to businesses_path if user_signed_in?
  end

end
