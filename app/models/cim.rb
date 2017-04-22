class Cim < ApplicationRecord
  has_many :cim_authorizations, dependent: :destroy
  has_many :cim_assets, dependent: :destroy
  extend FriendlyId
  validates_presence_of :name
  mount_uploader :html, CimHtmlUploader
  mount_uploader :pdf, CimPdfUploader
  friendly_id :slug_candidates, use: :slugged
  resourcify

  def to_param
    slug
  end

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

  def create_user_for_cim(email:)
    user = User.where(email: email).first
    if user.present?
      user.authorized_for_cim!(cim: self)
    else
      user = User.new(email: email)
      user.password =  password_for_email(email: email)
      user.password_confirmation = user.password
      user.cim = true
      user.save
      user.authorized_for_cim!(cim: self) if user.persisted?
    end
    user
  end

  def password_for_email(email:)
    Base64.encode64(email)[0..5].upcase
  end

  def authorized_users
    cim_authorizations.collect(&:user)
  end

end
