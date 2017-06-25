class DealRoom < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :deal_room_uploads
  has_many :deal_room_authorizations
  has_many :deal_room_invitations
  after_create :create_deal_room_authorization

  accepts_nested_attributes_for :deal_room_uploads

  def authorized_users
    deal_room_authorizations.includes(:user).collect(&:user)
  end

  def authorized?(user:)
    deal_room_authorizations.where(user: user).exists?
  end

 private

 def create_deal_room_authorization
   deal_room_authorizations.create(user: user)
 end

end
