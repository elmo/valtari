class Event < ApplicationRecord
  belongs_to :user
  belongs_to :industry_classification
  validates :title, presence: true
  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_presence_of :user_id
  validates_presence_of :location
  scope :future, -> (date) { where(["start_date >= ? ", date ]) }
  acts_as_ordered_taggable_on :tags
  mount_uploader :photo, PhotoUploader
end
 