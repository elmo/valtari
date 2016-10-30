class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :ebidtum, foreign_key: 'Ebidtum', foreign_key: 'ebitda_id'
  belongs_to :revenue
  belongs_to :industry
  has_many :campaign_industry_classifications
  has_many :industry_classifications, through: :campaign_industry_classifications, class_name: 'IndustryClassification'
  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :revenue_lower
  validates_presence_of :revenue_upper
  validates_presence_of :ebitda_lower
  validates_presence_of :ebitda_upper
  validates_presence_of :stage
  STAGE_SEED = 'Seed'
  STAGE_EARLY = 'Early'
  STAGE_EXPANSION = 'Expansion'
  STAGE_LATER = 'Later'
end
