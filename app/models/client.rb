module RushHour
  class Client < ActiveRecord::Base
    include ModelStatistics

    validates :identifier, presence: true, uniqueness: true
    validates :rootUrl,    presence: true

    has_many :payload_requests
    has_many :request_types, through: :payload_requests
    has_many :user_agent_strings, through: :payload_request
    has_many :urls, through: :payload_request
    has_many :resolutions, through: :payload_request

  end
end
