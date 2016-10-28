class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :ebidtum, foreign_key: 'Ebidtum', foreign_key: 'ebitda_id'
  belongs_to :revenue
  belongs_to :industry
  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :revenue_lower
  validates_presence_of :revenue_upper
  validates_presence_of :ebitda_lower
  validates_presence_of :ebitda_upper
  validates_presence_of :stage
  STAGE_SEED = 'seed'
  STAGE_EARLY = 'early'
  STAGE_EXPANSION = 'expansion'
  STAGE_LATER = 'later'
end
