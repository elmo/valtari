class DealRoomAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :deal_room
  after_create :log_activity

  private

  def log_activity
    deal_room.deal_room_activities.create(user: self.user, message: "#{self.user.email} authorized for room")
  end

end
