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
   has_many :capitals
   has_many :opportunities
   has_many :user_businesses
   has_many :businesses, through: :user_businesses
   has_many :searches
   has_many :notes
   has_many :events
   has_many :messages
   has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

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

end
