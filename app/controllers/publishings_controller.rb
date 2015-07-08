class PublishingsController < ApplicationController

  def create
      campaign = Campaign.find params[:campaign_id]
      if campaign.publish!
        redirect_to campaign, notice: "Campaign published"
      else
        redirect_to campaign, notice: "Can't publish, may already be published."
      end
  end
end
