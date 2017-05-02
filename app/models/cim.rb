class Cim < ApplicationRecord
  has_many :cim_authorizations, dependent: :destroy
  has_many :cim_assets, dependent: :destroy
  has_many :cim_accesses, dependent: :destroy
  extend FriendlyId
  validates_presence_of :name
  mount_uploader :html, CimHtmlUploader
  mount_uploader :pdf, CimPdfUploader
  friendly_id :slug_candidates, use: :slugged
  resourcify
  has_shortened_urls
  after_create :save_shortened_url

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
      user.password = password_for_email(email: email)
      user.password_confirmation = user.password
      user.cim = true
      user.save
      user.authorized_for_cim!(cim: self) if user.persisted?
    end
    user.send_cim_invitation(cim: self)
    user
  end

  def password_for_email(email:)
    Base64.encode64(email)[0..5].upcase
  end

  def authorized_users
    cim_authorizations.collect(&:user)
  end

  def save_shortened_url
    url = Rails.application.routes.url_helpers.welcome_private_cims_url(host: ENV['CIM_HOST'] )
    key = Base64.encode64(url)[0..6]
    Shortener::ShortenedUrl.generate(url, custom_key: key, owner: self)
  end

  def short_url
    save_shortened_url if shortened_urls.empty?
    Rails.application.routes.url_helpers.shortened_url(shortened_urls.last.unique_key, host: ENV['CIM_HOST'] )
  end

end
