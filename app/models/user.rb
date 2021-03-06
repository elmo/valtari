class User < ApplicationRecord
  rolify
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :lockable,
         :timeoutable
   devise :omniauthable, omniauth_providers: [:linkedin]
   mount_uploader :avatar, AvatarUploader

   belongs_to :organization, optional: true
   has_many :campaigns
   has_many :followings
   has_many :capitals
   has_many :opportunities
   has_many :user_businesses
   has_many :businesses, through: :user_businesses
   has_many :searches
   has_many :notes
   has_many :events
   has_many :messages
   has_many :verifications
   has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
   has_many :user_industry_classifications
   has_many :industry_classifications, through: :user_industry_classifications, class_name: 'IndustryClassification'
   has_many :cim_authorizations, dependent: :destroy
   has_many :cim_accesses, dependent: :destroy
   has_many :deal_rooms
   has_many :deal_room_uploads
   has_many :deal_room_authorizations
   has_many :deal_room_invitations
   has_many :deal_room_ndas

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

   def followed_users
     User.where(id: followings.collect(&:other_user_id) )
   end

   def following_users
     User.where(id: Following.where(other_user_id: self.id).collect(&:user_id) )
   end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def to_param
    slug
  end

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

  def master!
    add_role(:master)
  end

  def master?
    has_role?(:master)
  end

  def admin!
    add_role(:admin)
  end

  def admin?
    has_role?(:admin)
  end


  def editor!
    add_role(:editor)
  end

  def editor?
    has_role?(:editor)
  end

  def favorite_business?(business)
    user_businesses.exists?(business_id: business.id)
  end

  def all_messages
    Message.where(["user_id = ? or recipient_id = ? ", id, id ] )
  end

  def opened_messages
    Message.where(["(user_id = ? or recipient_id = ?) and opened = ? ", id, id, true ] )
  end

  def follow(other_user)
    followings.find_or_create_by(other_user_id: other_user.id)
  end

  def unfollow(other_user)
    followings.where(other_user_id: other_user.id).destroy_all
  end

  def following?(user)
    Following.exists?(user_id: self.id, other_user_id: user.id)
  end

  def authorized_for_cim!(cim:)
    cim_authorizations.find_or_create_by(cim_id: cim.id)
  end

  def authorized_for_cim?(cim:)
    cim_authorizations.exists?(cim_id: cim.id)
  end

  def deauthorized_for_cim!(cim:)
    cim_authorizations.where(cim_id: cim.id).destroy_all
  end

  def authorized_cims
    cim_authorizations.collect(&:cim)
  end

  def authorized_deal_rooms
    deal_room_authorizations.collect(&:deal_room)
  end

  def authorized_for_deal_room!(deal_room:)
    deal_room_authorizations.find_or_create_by(deal_room_id: deal_room.id)
  end

  def deauthorize_for_deal_room!(deal_room:)
    deal_room_authorizations.where(deal_room_id: deal_room.id).destroy_all
  end

  def client_for_cim!(cim: )
    add_role(:client, cim)
  end

  def remove_client_from_cim!(cim: )
    remove_role(:client, cim)
  end

  def client_for_cim?(cim: )
    has_role?(:client, cim)
  end

  def send_cim_invitation(cim:)
    CimMailer.invitation(user: self, cim: cim).deliver
  end

   def own!(obj)
     add_role :owner, obj
   end

   def owns?(obj)
     has_role?(:owner, obj)
   end

   def disown!(obj)
     remove_role(:owner, obj)
   end

   def license!(obj)
     add_role :license, obj
   end

   def licensed?(obj)
     has_role?(:license, obj)
   end

   def unlicensed!(obj)
     remove_role(:license, obj)
   end

   def guest!(obj)
     add_role :guest, obj
   end

   def guest?(obj)
     has_role?(:guest, obj)
   end

   def unguest!(obj)
     remove_role(:guest, obj)
   end

  def full_name
    return nil if first_name.blank? or last_name.blank?
    [first_name, last_name].join(' ')
  end

  def to_group
    email.split('@').last.split('.').first
  end

end
