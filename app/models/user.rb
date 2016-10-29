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
   devise :omniauthable, omniauth_providers: [:google_oauth2, :linkedin]

   mount_uploader :avatar, AvatarUploader

   has_many :campaigns
   has_many :capitals

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        byebug
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar = auth.info.image
      user.first_name = auth.extra.raw_info.first_name
      user.last_name = auth.extra.raw_info.last_name
      user.headline = auth.extra.raw_info.headline
      user.industry = auth.extra.raw_info.industry
      user.location = auth.extra.raw_info.location.name
      user.picture_url = auth.extra.raw_info.pictureUrl
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

end
