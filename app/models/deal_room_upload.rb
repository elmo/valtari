class DealRoomUpload < ApplicationRecord
  belongs_to :deal_room
  belongs_to :user
  before_validation :set_group
  scope :by_user, -> (user) { where(user: user) }
  scope :within_group, -> (group) { where(group: group) }

  mount_uploader :upload, UploadUploader
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  after_create :log_activity

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

  private

  def set_group
    self.group = user.email.split('@').last.gsub(/\W/, '') if group.blank?
  end

  def log_activity
    deal_room.deal_room_activities.create(
        user: self.user,
        message: "#{self.user.email}
        uploaded file: #{self.original_file_name}"
    )
  end

end
