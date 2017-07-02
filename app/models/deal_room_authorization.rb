class DealRoomAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :deal_room
  before_validation :set_group
  after_create :log_activity
  scope :accepted_and_invited_by, -> (deal_room, user) { where(user_id: deal_room.deal_room_invitations.accepted.collect(&:user_id)  ) }
  scope :within_group, -> (group) { where(group: group) }

  private

  def set_group
    self.group = user.email.split('@').last
  end


  def accept_invitation
    deal_room.deal_room_invitations.where(user: user).each {|invitation| invitation.accepted! }
  end

  def log_activity
    deal_room.deal_room_activities.create(user: self.user, message: "#{self.user.email} authorized for room")
  end

end
