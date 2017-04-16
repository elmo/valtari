class Cim < ApplicationRecord
  validates_presence_of :name
  mount_uploader :html, CimHtmlUploader
  mount_uploader :pdf, CimPdfUploader
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def to_param
    slug
  end

  def slug_candidates
    [Base64.encode64(SecureRandom.uuid)[0..10]]
  end

end
