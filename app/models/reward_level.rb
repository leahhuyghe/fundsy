class RewardLevel < ActiveRecord::Base

  belongs_to :campaign
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than: 10}

end
