class CimPdfUploader < CarrierWave::Uploader::Base
  storage :postgresql_lo

  def extension_white_list
    %w(pdf)
  end

end
