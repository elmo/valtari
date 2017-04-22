module CimAssetsHelper

  def cim_asset_location(filename:)
    cim_asset = CimAsset.find_by(filename: filename)
    private_cim_cim_asset_url(cim_asset.cim, cim_asset)
  end

  def include_cim_asset_data(filename:)
    cim_asset = CimAsset.find_by(filename: filename)
    cim_asset.data.read
  end

end
