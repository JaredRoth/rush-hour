class Url < ActiveRecord::Base
  validates :url, presence: true
  has_many :payload_requests

  def self.sort_most_requested
    group(:url).count.group_by{|k,v|v}.values

    group(:url).count.to_a.sort.reverse[0][0]
  end
end
