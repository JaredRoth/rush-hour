class UserAgentString < ActiveRecord::Base
  validates :user_agent_string, presence: true
  has_many :payload_requests

  def self.browser_breakdown
    # require 'pry'; binding.pry
    pluck(:user_agent_string).map do |string|
      UserAgent.parse(string).browser
    end.uniq
  end

  def self.operating_system_breakdown
    # require 'pry'; binding.pry
    pluck(:user_agent_string).map do |string|
      UserAgent.parse(string).platform
    end.uniq
  end
end
