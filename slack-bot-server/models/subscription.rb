class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps

  SORT_ORDERS = ['created_at', '-created_at', 'updated_at', '-updated_at']

  field :team_id, type: String
  field :channel_id, type: String
  field :dbo_id, type: String
  field :last_delivery_date, type: Date
  field :active, type: Boolean, default: true

  scope :active, -> { where(active: true) }

  validates_presence_of :team_id
  validates_presence_of :channel_id
  validates_presence_of :dbo_id

end