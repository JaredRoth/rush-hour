class UserAgentString < ActiveRecord::Base
  validates :user_agent_string, presence: true
  has_many :payload_requests
  has_many :urls, through: :payload_requests

  def self.browser_breakdown
    pluck(:user_agent_string).map do |string|
      UserAgent.parse(string).browser
    end.uniq
  end

  def self.operating_system_breakdown
    pluck(:user_agent_string).map do |string|
      UserAgent.parse(string).platform
    end.uniq
  end

  def self.user_agent
    pluck(:user_agent_string).map do |string|
      "#{UserAgent.parse(string).browser}, #{UserAgent.parse(string).platform}"
    end
  end
end
