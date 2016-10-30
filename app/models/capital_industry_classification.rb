class CapitalIndustryClassification < ApplicationRecord
   belongs_to :capital, optional: true
   belongs_to :industry_classification, optional: true
   accepts_nested_attributes_for :industry_classification, :reject_if => :all_blank
end
