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
   has_many :cim_authorizations

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


end
