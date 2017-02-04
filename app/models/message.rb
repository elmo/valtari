class Message < ApplicationRecord
   belongs_to :user
   belongs_to :recipient,  class_name: 'User', foreign_key: "recipient_id"
   validates_presence_of :user_id
   validates_presence_of :recipient_id
   scope :opened, -> { where( opened: true) }
   scope :unopened, -> { where( opened: false ) }

   def open!
     update_attributes(opened: true, opened_at: Time.zone.now)
   end

   def opened?
     opened == true
   end

end
