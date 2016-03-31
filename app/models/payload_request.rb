class PayloadRequest < ActiveRecord::Base
  validates :requested_at,    presence: true
  validates :responded_in,    presence: true
  validates :url_id,          presence: true
  validates :referrer_id,     presence: true
  validates :request_type_id, presence: true
  validates :event_id,        presence: true
  validates :user_agent_string_id,   presence: true
  validates :resolution_id,   presence: true
  validates :ip_id,           presence: true

  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :event
  belongs_to :user_agent_string
  belongs_to :resolution
  belongs_to :ip

  def self.avg_response_time
    average(:responded_in).to_f.round(2)
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end
end
