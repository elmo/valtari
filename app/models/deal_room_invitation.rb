class DealRoomInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :deal_room
  validates_presence_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  before_validation :find_or_create_user_for_deal_room
  after_create :send_invitation_by_email
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

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
    Base64.encode64(email)[0..5].upcase
  end

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

  private

  def send_invitation_by_email
    p "sending email"
  end


end
