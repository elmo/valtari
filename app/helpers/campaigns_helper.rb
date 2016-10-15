module CampaignsHelper

  def campaign_revenue_options
    Revenue.all.collect {|r| [r.name, r.id] }
  end

  def ebidta_options
    Ebidtum.all.collect {|e| [e.name, e.id] }
  end

end
