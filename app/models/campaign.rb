class Campaign < ApplicationRecord
  belongs_to :user
  has_many :industries
  belongs_to :ebidtum
  belongs_to :revenue
  validates_presence_of :user
  validates_presence_of :revenue
  validates_presence_of :ebidtum
end
