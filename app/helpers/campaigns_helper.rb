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

  def company_stage_options
    [
      Campaign::STAGE_SEED,
      Campaign::STAGE_EARLY,
      Campaign::STAGE_EXPANSION,
      Campaign::STAGE_LATER
    ]
  end

  def campaign_published_link(campaign)
    (campaign.published?) ? link_to('unpublish', unpublish_my_campaign_path(campaign), method: :put)  : link_to('publish',  publish_my_campaign_path(campaign), method: :put )
  end

end
