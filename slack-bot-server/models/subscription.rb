class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps

  SORT_ORDERS = ['created_at', '-created_at', 'updated_at', '-updated_at']

  field :dbo_id, type: String
  field :channel_id, type: String
  field :course_slug, type: String
  field :last_delivery_date, type: Date

  embeds_one :team

  validates_presence_of :channel_id
  validates_presence_of :dbo_id

end