# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :postgresql_lo

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
   end

   process resize_to_fit: [500, 500]

  # Create different versions of your uploaded files:
   version :thumb do
     process :resize_to_fill => [100, 100]
   end

   def content_type_whitelist
     /image\//
   end

  def extension_white_list
     %w(jpg jpeg gif png)
  end

end
