module CampaignsHelper

  def revenue_options
    Revenue.all.collect {|r| [r.name, r.id] }
  end

  def ebidta_options
    Ebidtum.all.collect {|e| [e.name, e.id] }
  end

  def industry_options
    Industry.all.collect {|i| [i.name, i.id] }
  end

end
