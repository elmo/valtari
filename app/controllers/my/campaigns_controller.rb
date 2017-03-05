class My::CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = current_user.campaigns.order(created_at: :desc).page(params[:page]).per(10)
    @capitals = current_user.capitals.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @campaign = current_user.campaigns.new
  end

  def edit
  end

  def create
    @campaign = current_user.campaigns.new(campaign_params)
    respond_to do |format|
      if @campaign.save
        format.html { redirect_to my_campaigns_path, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to  edit_my_campaign_path(@campaign) , notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to my_campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_campaign
      @campaign = current_user.campaigns.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :stage, :revenue_lower, :revenue_upper, :ebitda_lower, :ebitda_upper, industry_classification_ids: [] )
    end
end
