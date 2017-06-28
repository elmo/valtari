class UploadUploader < CarrierWave::Uploader::Base
  storage :postgresql_lo
end
