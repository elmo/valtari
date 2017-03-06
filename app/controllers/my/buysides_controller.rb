class My::BuysidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buyside, only: [:show, :edit, :update, :destroy]

  def index
    @buysides = current_user.buysides.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @buyside = current_user.buysides.new
  end

  def edit
  end

  def create
    @buyside = current_user.buysides.new(buyside_params)
    respond_to do |format|
      if @buyside.save
        format.html { redirect_to my_buysides_path, notice: 'Buyside was successfully created.' }
        format.json { render :show, status: :created, location: @buyside }
      else
        format.html { render :new }
        format.json { render json: @buyside.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @buyside.update(buyside_params)
        format.html { redirect_to  edit_my_buyside_path(@buyside) , notice: 'Buyside was successfully updated.' }
        format.json { render :show, status: :ok, location: @buyside }
      else
        format.html { render :edit }
        format.json { render json: @buyside.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @buyside.destroy
    respond_to do |format|
      format.html { redirect_to my_buysides_url, notice: 'Buyside was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_buyside
      @buyside = current_user.buysides.find(params[:id])
    end

    def buyside_params
      params.require(:buyside).permit(:title, :stage, :revenue_lower, :revenue_upper, :ebitda_lower, :ebitda_upper, industry_classification_ids: [] )
    end
end
