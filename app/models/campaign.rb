class Campaign < ActiveRecord::Base
  belongs_to :user

  has_many :pledges, dependent: :destroy
  has_many :reward_levels, depend: :destroy

  scope :published, lambda { where(aasm_state: :published) }

  include AASM

  aasm  :whiny_transitions => false do
    state :draft, initial: true
    state :published
    state :cancelled
    state :failed
    state :goal_attained

    event :publish do
      transitions from: :draft, to: :published
    end

    event :cancel do
      transitions from: [:published, :draft], to: :cancelled
    end

    event :restore do
      transitions from: :cancelled, to: :draft
    end

    event :win do
      transitions from: :published, to: :goal_attained
    end

    event :lose do
      transitions from: :published, to: :failed
    end

    event :recycle do
      transitions from: :failed, to: :draft
    end

  end

  accepts_nested_attributes_for :reward_levels, reject_if: lambda { |x| x[:amount].empty? && x[:title].empty? && x[:description].empty? }

  validates :reward_levels, presence: true
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than: 10}




end
