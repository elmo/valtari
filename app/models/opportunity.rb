class Opportunity < ApplicationRecord
  belongs_to :user
  belongs_to :ebidtum, foreign_key: 'Ebidtum', foreign_key: 'ebitda_id', optional: true
  belongs_to :revenue, optional: true
  belongs_to :industry, optional: true
  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :revenue_amount
  validates_presence_of :ebidta_amount
  has_many :opportunity_industry_classifications
  has_many :industry_classifications, through: :opportunity_industry_classifications, class_name: 'IndustryClassification'
end
