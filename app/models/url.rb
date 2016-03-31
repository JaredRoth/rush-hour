class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :user_agent_strings, through: :payload_requests

  def self.sort_most_requested
    joins(:payload_requests).group(:url).count.sort_by{|k,v|v}.reverse.map{|pair| pair[0]}
  end

  def urls_max_response_time
    payload_requests.maximum(:responded_in)
  end

  def urls_min_response_time
    payload_requests.minimum(:responded_in)
  end

  def sort_urls_response_times
    payload_requests.order(responded_in: :desc).pluck(:responded_in)
  end

  def urls_avg_response_time
    payload_requests.average(:responded_in).to_f.round(2)
  end

  def urls_request_types
    request_types.pluck(:request_type).uniq
  end

  def urls_top_referrers
    referrers.group(:referred_by).count.sort_by{|k,v|v}.reverse.map{|pair| pair[0]}[0..2]
  end

  def urls_top_user_agents
    user_agent_strings.user_agent.group_by{|i|i}.sort_by{|k,v| v.count}.reverse.map{|pair| pair[0]}[0..2]
  end
end
