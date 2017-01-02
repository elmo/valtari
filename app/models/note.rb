class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :user
  validates_presence_of :user
  validates_presence_of :notable_type
  validates_presence_of :notable_id
end
