class DealRoomAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :deal_room
  after_create :log_activity
  after_create :accept_invitation

  private

  def accept_invitation
    deal_room.deal_room_invitations.where(user: user).each {|invitation| invitation.accepted! }
  end

  def log_activity
    deal_room.deal_room_activities.create(user: self.user, message: "#{self.user.email} authorized for room")
  end

end
