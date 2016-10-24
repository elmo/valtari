class Admin::SicCodesController < Admin::AdminController
  before_action :set_sic_code, only: [:show, :edit, :update, :destroy]

  def index
    @sic_codes = SicCode.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @sic_code = SicCode.new
  end

  def edit
  end

  def create
    @sic_code = SicCode.new(sic_code_params)

    respond_to do |format|
      if @sic_code.save
        format.html { redirect_to admin_sic_code_path(@sic_code), notice: 'SicCode was successfully created.' }
        format.json { render :show, status: :created, location: @sic_code }
      else
        format.html { render :new }
        format.json { render json: @sic_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sic_code.update(sic_code_params)
        format.html { redirect_to admin_sic_code_path(@sic_code), notice: 'SicCode was successfully created.' }
        format.json { render :show, status: :ok, location: @sic_code }
      else
        format.html { render :edit }
        format.json { render json: @sic_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sic_code.destroy
    respond_to do |format|
      format.html { redirect_to admin_industries_url, notice: 'SicCode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_sic_code
      @sic_code = SicCode.find(params[:id])
    end

    def sic_code_params
      params.require(:sic_code).permit(:name, :code)
    end
end
