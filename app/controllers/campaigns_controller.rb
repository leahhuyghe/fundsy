class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.published 
  end

  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).
                        permit(:title, :description, :due_date, :goal)
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created!"
    else
      #this will generate an associated number of reward levels that is the difference between the default number and the accepted count.
      reward_level_count = @campaign.reward_levels.length
      reward_level_count.times { @campaign.reward_levels.build}
      render :new
    end
  end

  def edit
    @campaign = current_user.campaigns.find params[:id]
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def update
    @campaign = current_user.campaigns.find params[:id]
    campaign_params = params.require(:campaign).
                        permit(:title, :description, :due_date, :goal)
    if @campaign.update campaign_params
      # redirect_to @campaign
      redirect_to campaign_path(@campaign), notice: "updated!"
    else
      flash[:alert] = "update unsuccessful"
      render :edit
    end
  end

  def destroy
    @campaign.destroy
      redirect_to campaigns_path, notice: "Campaign deleted"
  end

private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :due_date, :goal)
  end

  def find_campaign
    @campaign = current_user.campaigns.find params[:id]
  end

  def campaign_params
    params.require(:campaign).permit(:title, :description, :due_date, :goal, {reward_levels_attributes: [:title, :description, :amount]})
  end



end
