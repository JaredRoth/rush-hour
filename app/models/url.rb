class Url < ActiveRecord::Base
  validates :url, presence: true
  has_many :payload_requests

  def self.sort_most_requested
    group(:url).count.sort_by{|k,v|v}.reverse.map{|pair| pair[0]}
  end
end
