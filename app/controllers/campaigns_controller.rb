class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  private

  def set_campaign
   @campaign = Campaign.find(params[:id])
 end

end
