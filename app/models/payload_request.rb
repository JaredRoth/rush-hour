class PayloadRequest < ActiveRecord::Base
  validates :requested_at,    presence: true
  validates :responded_in,    presence: true
  validates :url_id,          presence: true
  validates :referrer_id,     presence: true
  validates :request_type_id, presence: true
  validates :event_id,        presence: true
  validates :user_agent_id,   presence: true
  validates :resolution_id,   presence: true
  validates :ip_id,           presence: true

  belongs_to :urls
  belongs_to :referrers
  belongs_to :request_types
  belongs_to :events
  belongs_to :user_agent_strings
  belongs_to :resolutions
  belongs_to :ips

  def self.avg_response_time
    average(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end
end
