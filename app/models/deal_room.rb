class DealRoom < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :deal_room_uploads
  accepts_nested_attributes_for :deal_room_uploads
end
