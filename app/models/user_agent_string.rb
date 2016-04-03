class UserAgentString < ActiveRecord::Base
  validates :user_agent_os, presence: true
  validates :user_agent_browser, presence: true

  has_many :payload_requests
  has_many :urls, through: :payload_requests

  def self.browser_breakdown
    pluck(:user_agent_browser).uniq
  end

  def self.operating_system_breakdown
    pluck(:user_agent_os).uniq
  end
end
