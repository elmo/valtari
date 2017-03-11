class BuysideIndustryClassification < ApplicationRecord
   belongs_to :buyside, optional: true
   belongs_to :industry_classification
   accepts_nested_attributes_for :industry_classification, :reject_if => :all_blank
end