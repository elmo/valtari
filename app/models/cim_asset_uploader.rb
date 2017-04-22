class CimAssetUploader < CarrierWave::Uploader::Base
  storage :postgresql_lo

  def extension_white_list
    %w(css jpg png gif js)
  end

end
