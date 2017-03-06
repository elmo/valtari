class BuysidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buyside, only: [:show, :edit, :update, :destroy]

  def index
    @buysides = Buyside.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  private

  def set_buyside
   @buyside = Buyside.find(params[:id])
 end

end
