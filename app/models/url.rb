class Url < ActiveRecord::Base
  validates :url, presence: true
  validates :url, uniqueness: true

  has_many :payload_requests

  def self.sort_most_requested
    joins(:payload_requests).group(:url).count.sort_by{|k,v|v}.reverse.map{|pair| pair[0]}
  end

  def max_response_time
   payload_requests.maximum(:responded_in)
 end

  def min_response_time
   payload_requests.minimum(:responded_in)
 end
end
