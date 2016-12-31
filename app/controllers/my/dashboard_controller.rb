class My::DashboardController < ApplicationController
  before_action :authenticate_user!

  def profile
  end

end
