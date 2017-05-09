class CimInquiry < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :company
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
