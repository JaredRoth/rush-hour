class Event < ActiveRecord::Base
  validates :event_name, presence: true
  has_many :payload_requests

  def self.sort_most_received
    group(:event_name).count.sort_by{|k,v|v}.reverse.map{|pair| pair[0]}
  end
end
