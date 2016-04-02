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

  def sort_clients_most_requested_urls
    urls.group(:url).order("count_all desc").count.keys
  end

end
