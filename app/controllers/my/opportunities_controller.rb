class My::OpportunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def index
    @opportunities = current_user.opportunities.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @opportunity = current_user.opportunities.new
  end

  def edit
  end

  def create
    @opportunity = current_user.opportunities.new(opportunity_params)
    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to my_opportunities_path, notice: 'Opportunity was successfully created.' }
        format.json { render :show, status: :created, location: @opportunity }
      else
        format.html { render :new }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @opportunity.update(opportunity_params)
        format.html { redirect_to  edit_my_opportunity_path(@opportunity) , notice: 'Opportunity was successfully updated.' }
        format.json { render :show, status: :ok, location: @opportunity }
      else
        format.html { render :edit }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @opportunity.destroy
    respond_to do |format|
      format.html { redirect_to my_opportunities_url, notice: 'Opportunity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish
    @opportunity.publish!
    respond_to do |format|
      format.html { redirect_to my_opportunities_url, notice: 'Opportunity was successfully published.' }
      format.json { head :no_content }
    end
  end

  def unpublish
    @opportunity.unpublish!
    respond_to do |format|
      format.html { redirect_to my_opportunities_url, notice: 'Opportunity was successfully has been unpublished.' }
      format.json { head :no_content }
    end
  end

  private

    def set_opportunity
      @opportunity = current_user.opportunities.find(params[:id])
    end

    def opportunity_params
      params.require(:opportunity).permit(:title, :revenue_amount, :ebidta_amount, industry_classification_ids: [] )
    end
end
