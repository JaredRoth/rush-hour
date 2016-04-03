class Url < ActiveRecord::Base
  include ModelStatistics
  validates :url, presence: true

  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :user_agent_strings, through: :payload_requests
  has_many :clients, through: :payload_requests

  def self.sort_most_requested
    joins(:payload_requests).group(:url)
    .order("count_all desc").count.keys
  end

  def sort_response_times
    payload_requests.order(responded_in: :desc).pluck(:responded_in)
  end

  def top_three_referrers
    referrers.group(:referred_by).order("count_all desc").limit(3).count.keys
  end

  def top_three_user_agents
    user_agent_strings.group(:user_agent_browser, :user_agent_os)
    .order("count_all desc").limit(3).count.keys
  end
end
