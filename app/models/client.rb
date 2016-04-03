require_relative 'model_statistics'

class Client < ActiveRecord::Base
  include ModelStatistics

  validates :identifier, presence: true, uniqueness: true
  validates :rootUrl,    presence: true

  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :user_agent_strings, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :events, through: :payload_requests

  def clients_most_frequent_request_type
    request_types.group(:request_type).order("count_all desc").count.keys.first
  end

  def sort_clients_most_requested_urls
    urls.group(:url).order("count_all desc").count.keys
  end

  def clients_browser_breakdown
    user_agent_strings.pluck(:user_agent_browser).uniq
  end

  def clients_operating_system_breakdown
    user_agent_strings.pluck(:user_agent_os).uniq
  end

  def list_clients_resolutions
    client_resolutions = resolutions.pluck(:resolution_width,
                                           :resolution_height).uniq

    client_resolutions.map do |width, height|
        width.to_s + 'x' + height.to_s
    end
  end

  def list_clients_events
    events.pluck(:event_name).uniq
  end
end
