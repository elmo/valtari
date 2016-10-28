class My::CapitalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_capital, only: [:show, :edit, :update, :destroy]

  def index
    @capitals = current_user.capitals.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @capital = current_user.capitals.new
  end

  def edit
  end

  def create
    @capital = current_user.capitals.new(capital_params)
    respond_to do |format|
      if @capital.save
        format.html { redirect_to my_capital_path(@capital), notice: 'Capital campaign was successfully created.' }
        format.json { render :show, status: :created, location: @capital }
      else
        format.html { render :new }
        format.json { render json: @capital.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @capital.update(capital_params)
        format.html { redirect_to  my_capital_path(@capital) , notice: 'Capital campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @capital }
      else
        format.html { render :edit }
        format.json { render json: @capital.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @capital.destroy
    respond_to do |format|
      format.html { redirect_to my_capitals_url, notice: 'Capital campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_capital
      @capital = current_user.capitals.find(params[:id])
    end

    def capital_params
      params.require(:capital).permit(:title, :stage, :revenue_lower, :revenue_upper, :ebitda_lower, :ebitda_upper, :industry_id)
    end
end
