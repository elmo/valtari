class Private::CimAssetsController < Private::PrivateController
  before_action :set_cim
  before_action :set_cim_asset, only: [:show, :destroy]
  before_action :admin_only

  def index
    @cim_assets = @cim.cim_assets
  end

  def new
    @cim_asset = @cim.cim_assets.new
  end

  def show
    send_data(@cim_asset.data.read, filename: @cim_asset.filename, dispostion: "inline" )
  end

  def create
    @cim_asset = @cim.cim_assets.new(cim_asset_params)
    @cim_asset.filename = @cim_asset.data.file.original_filename if @cim_asset.data.present?
    respond_to do |format|
      if @cim_asset.save
        format.html { redirect_to edit_private_cim_path(@cim), notice: 'CimAsset was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @cim_asset.destroy
    respond_to do |format|
      format.html { redirect_to edit_private_cim_path(@cim), notice: 'CimAsset was successfully deleted.' }
    end
  end

  private

  def admin_only
    not_found unless current_user.admin?
  end

  def set_cim
    @cim = Cim.friendly.find(params[:cim_id])
  end

  def set_cim_asset
    @cim_asset = CimAsset.find(params[:id])
  end

  def cim_asset_params
    params.require(:cim_asset).permit(:filename,:data)
  end

end
