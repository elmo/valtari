class CimInquiry < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :phone
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  after_create :notify_admin

  private

  def notify_admin
   CimMailer.notify_admin(cim_inquiry: self).deliver
  end

end
