class Verification < ApplicationRecord
  belongs_to :user
  belongs_to :business
  belongs_to :assigned_user, foreign_key: "assigned_to_user_id", class_name: "User", optional: true
  belongs_to :completed_by_user, foreign_key: "completed_by_user_id", class_name: "User", optional: true
  after_create :update_business

  STATUS_NEW = 'new'
  STATUS_PENDING = 'pending'
  STATUS_COMPLETE = 'complete'

  scope :assigned  , -> { where.not(assigned_user: nil) }
  scope :unassigned, -> { where( assigned_user: nil) }
  scope :status_new, -> { where(status: STATUS_NEW) }
  scope :status_pending, -> { where(status: STATUS_PENDING ) }
  scope :status_complete, -> { where(status: STATUS_COMPLETE ) }
  scope :for_user, -> (user) { where(user: user) }
  scope :for_business, -> (business) { where(business: business) }

  def assigned?
    assigned_user.present?
  end

  def assign_to(user:)
    update(assigned_user: user)
    status_pending!
  end

  def unassign!
    update(assigned_user: nil)
    status_new!
  end

  def status_new!
     update(status: STATUS_NEW)
  end

  def status_new?
     status == STATUS_NEW
  end

  def status_pending!
     update(status: STATUS_PENDING)
  end

  def status_pending?
     status == STATUS_PENDING
  end

  def status_complete!
    update(status: STATUS_COMPLETE)
  end

  def completed_by!(user: user)
    update_attributes(status: STATUS_COMPLETE, completed_by_user_id: user.id)
  end

  def status_complete?
    status == STATUS_COMPLETE
  end

  private

  def update_business
    status_new!
    business.update_attributes(last_verified_by: user, last_verified: Time.zone.now)
  end

end
