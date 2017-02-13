class Event < ApplicationRecord
  belongs_to :user
  belongs_to :industry_classification
  validates_presence_of :title
  validates_presence_of :user_id
  scope :future, -> (date) { where(["start_date >= ? ", date ]) }
  acts_as_ordered_taggable_on :tags
  mount_uploader :photo, PhotoUploader
end
