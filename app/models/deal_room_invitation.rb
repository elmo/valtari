class DealRoomInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :deal_room
  belongs_to :inviter, class_name: 'User', foreign_key: 'inviting_user_id'
  validates_presence_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :inviter, presence: true
  before_validation :set_group
  before_validation :find_or_create_user_for_deal_room
  after_create :send_invitation_by_email
  after_create :log_activity
  scope :invited_by, -> (user) { where(inviting_user_id: user.id) }
  scope :accepted, -> {where(status: STATUS_ACCECPTED) }
  scope :within_group, -> (group) { where(group: group) }

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  STATUS_NEW = 'new'
  STATUS_SENT = 'sent'
  STATUS_ACCECPTED = 'accepted'

  def find_or_create_user_for_deal_room
    u = User.where(email: email).first
    if !u.present?
      u = User.new(email: email)
      u.password = password_for_email(email: email)
      u.password_confirmation = u.password
      u.save
    end
    self.user = u
  end

  def password_for_email(email:)
    SecureRandom.hex(3).upcase
  end

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

  def resend
    DealRoomMailer.invitation(user: user, deal_room: deal_room).deliver
    deal_room.deal_room_activities.create(user: user, message: "Invitation to #{user.email} resent.")
  end

  def accepted!
    update_attributes(status: STATUS_ACCECPTED)
  end

  def accepted?
    status == STATUS_ACCECPTED
  end

  private

  def set_group
    self.group = user.email.split('@').last.gsub(/\W/, '')
  end

  def send_invitation_by_email
    DealRoomMailer.invitation(user: user, deal_room: deal_room).deliver
    update_attributes(status: STATUS_SENT)
  end

  def log_activity
    deal_room.deal_room_activities.create(user: user, message: "#{user.email} invited to room")
  end

end
