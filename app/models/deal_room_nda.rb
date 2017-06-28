class DealRoomNda < ApplicationRecord
  belongs_to :user
  belongs_to :deal_room
  belongs_to :deal_room_invitation
  validates :user, presence: true
  validates :deal_room, presence: true
  validates :signature,  presence: true
  #validates :ip_address, presence: true
  #validates :deal_room_invitation_id, presence: true
  validates :i_have_read, inclusion: { in: [ true] , message: " must be checked"}
  validates :i_agree, inclusion: { in: [ true] , message: " must be checked"}
  after_create :create_deal_room_authorization

  private

  def create_deal_room_authorization
     user.authorized_for_deal_room!(deal_room: deal_room)
  end

end
