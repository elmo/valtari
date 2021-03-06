class DealRoom < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :company_name, presence: true
  has_many :deal_room_uploads
  has_many :deal_room_authorizations
  has_many :deal_room_invitations
  has_many :deal_room_activities
  has_many :notes, as: :notable
  after_create :create_deal_room_authorization
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  accepts_nested_attributes_for :deal_room_uploads

  resourcify

  def to_param
    slug
  end

  def authorized_users
    deal_room_authorizations.includes(:user).collect(&:user)
  end

  def authorized?(user:)
    self.user == user or deal_room_authorizations.where(user: user).exists?
  end

  def owned_by?(user:)
    self.user == user
  end

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

  def self.password_for_email(email:)
    Digest::MD5.hexdigest(email)[0..5].upcase
  end

  def distinct_groups
    deal_room_authorizations.pluck(:group).uniq
  end

 private

 def create_deal_room_authorization
   deal_room_authorizations.create(user: user)
 end

end
