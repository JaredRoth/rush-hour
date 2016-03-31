class RequestType < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payload_requests
  has_many :urls, through: :payload_requests, source: "url_id"

  def self.most_frequent
    joins(:payload_requests).group(:request_type).count.max_by{|k,v|v}.first
  end

  def self.list_all_verbs
    distinct.pluck(:request_type)
  end
end
