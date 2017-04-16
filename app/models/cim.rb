class Cim < ApplicationRecord
  extend FriendlyId
  validates_presence_of :name
  mount_uploader :html, CimHtmlUploader
  mount_uploader :pdf, CimPdfUploader

  friendly_id :slug_candidates, use: :slugged

  def to_param
    slug
  end

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

end
