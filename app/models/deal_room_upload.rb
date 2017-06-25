class DealRoomUpload < ApplicationRecord
  belongs_to :deal_room
  belongs_to :user
  mount_uploader :upload, UploadUploader
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

end
