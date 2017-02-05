class Event < ApplicationRecord
  belongs_to :user
  validates_presence_of :title
  validates_presence_of :user_id
  scope :future, -> (date) { where(["start_time >= ? ", date ]) }
  acts_as_ordered_taggable_on :tags
end
