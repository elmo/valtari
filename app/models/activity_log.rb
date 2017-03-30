class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :business
  scope :for_user, -> (user) { where(user_id: user.id ) }
  scope :for_business, -> (user) { where(business_id: business.id) }
end
