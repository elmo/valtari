module CapitalsHelper

  def industry_classifications_options
    IndustryClassification.all.collect {|r| [r.name, r.id] }
  end

end
