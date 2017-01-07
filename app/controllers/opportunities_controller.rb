class OpportunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

  def index
    @opportunities = Opportunity.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  private

  def set_opportunity
   @opportunity = Opportunity.find(params[:id])
 end

end
