class Admin::GeosController < Admin::AdminController
  before_action :set_geo, only: [:show, :edit, :update, :destroy]

  def index
    scope = Geo
    scope = scope.where(division1: params[:division1 ]) if params[:division1].present?
    scope = scope.where(division2: params[:division2] ) if params[:division2].present?
    scope = scope.where(division3: params[:division3] ) if params[:division3].present?
    scope = scope.where(division4: params[:division4] ) if params[:division4].present?
    @geos = scope.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @geo = Geo.new
  end

  def edit
  end

  def create
    @geo = Geo.new(geo_params)

    respond_to do |format|
      if @geo.save
        format.html { redirect_to admin_geo_path(@geo), notice: 'Geo was successfully created.' }
        format.json { render :show, status: :created, location: @geo }
      else
        format.html { render :new }
        format.json { render json: @geo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @geo.update(geo_params)
        format.html { redirect_to admin_geo_path(@geo), notice: 'Geo was successfully created.' }
        format.json { render :show, status: :ok, location: @geo }
      else
        format.html { render :edit }
        format.json { render json: @geo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @geo.destroy
    respond_to do |format|
      format.html { redirect_to admin_geos_url, notice: 'Geo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_geo
      @geo = Geo.find(params[:id])
    end

    def geo_params
      params.require(:geo).permit(:name, :code)
    end
end
