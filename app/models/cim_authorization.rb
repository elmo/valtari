class CimAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :cim
  validates_presence_of :user_id
  validates_presence_of :cim_id
end
