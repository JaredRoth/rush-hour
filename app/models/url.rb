class Url < ActiveRecord::Base
  include ModelStatistics
  validates :url, presence: true

  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :user_agent_strings, through: :payload_requests

  def self.sort_most_requested
    joins(:payload_requests).group(:url).order("count_all desc").count.keys
  end
end
