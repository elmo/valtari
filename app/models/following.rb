class Following < ApplicationRecord
   belongs_to :user
   belongs_to :other_user, class_name: 'User', foreign_key: 'other_user_id'
end
