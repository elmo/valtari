class Capital < ApplicationRecord
  belongs_to :user
  has_many :capital_industry_classifications
  has_many :industry_classifications, through: :capital_industry_classifications, class_name: 'IndustryClassification'
  accepts_nested_attributes_for :capital_industry_classifications

end
