class CimHtmlUploader < CarrierWave::Uploader::Base
  storage :postgresql_lo

  def extension_white_list
    %w(html)
  end

end
