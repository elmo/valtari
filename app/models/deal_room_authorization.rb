class DealRoomAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :deal_room
end
