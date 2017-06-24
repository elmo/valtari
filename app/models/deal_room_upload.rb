class DealRoomUpload < ApplicationRecord
  belongs_to :deal_room
  belongs_to :user
  mount_uploader :upload, UploadUploader
end
