class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:splash]
end
