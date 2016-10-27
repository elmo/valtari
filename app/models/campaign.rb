class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :ebidtum, foreign_key: 'Ebidtum', foreign_key: 'ebitda_id'
  belongs_to :revenue
  belongs_to :industry
  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :revenue_id
  validates_presence_of :ebitda_id
  STAGE_SEED = 'seed'
  STAGE_EARLY = 'early'
  STAGE_EXPANSION = 'expansion'
  STAGE_LATER = 'later'
end
