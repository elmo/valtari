class CapitalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_capital, only: [:show, :edit, :update, :destroy]

  def index
    @capitals = Capital.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  private

  def set_capital
   @capital = Capital.find(params[:id])
 end

end
