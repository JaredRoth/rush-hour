class RequestType < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payload_requests
  has_many :urls, through: :payload_requests
  has_many :clients, through: :payload_requests

  def self.most_frequent_request_types
    joins(:payload_requests).group(:request_type).order("count_all desc").count.keys.first
    # try to refactor using order
  end

  def self.list_all_verbs
    distinct.pluck(:request_type)
  end
end
