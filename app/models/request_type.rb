class RequestType < ActiveRecord::Base
  validates :request_type, presence: true
  has_many :payload_requests

  def self.most_frequent
    group(:request_type).count.max_by{|k,v|v}.first
  end

  def self.list_all_verbs
    distinct.pluck(:request_type)
  end
end
