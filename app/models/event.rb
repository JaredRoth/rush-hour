class Event < ActiveRecord::Base
  validates :event_name, presence: true
  has_many :payload_requests

  has_many :clients, through: :payload_requests

  def self.sort_most_received
    joins(:payload_requests).group(:event_name)
    .order("count_all desc").count.keys
  end

  def hourly_requests
    payload_requests.select('EXTRACT(HOUR from requested_at)')
    .group('EXTRACT(HOUR FROM requested_at)').count
  end

  def total_count
    payload_requests.count
  end
end
