class CimAsset < ApplicationRecord
   belongs_to :cim
   mount_uploader :data, CimAssetUploader
  def extension_white_list
    %w(js css scss jpg png gif)
  end
end
