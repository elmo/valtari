class PhotoUploader < CarrierWave::Uploader::Base
  storage :postgresql_lo

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
