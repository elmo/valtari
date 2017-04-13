module OpportunitiesHelper

  def opportunity_published_link(opportunity)
    (opportunity.published?) ? link_to('unpublish', unpublish_my_opportunity_path(opportunity), method: :put )  : link_to('publish',  publish_my_opportunity_path(opportunity), method: :put)
  end

end
