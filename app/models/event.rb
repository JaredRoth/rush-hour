class Event < ActiveRecord::Base
  validates :event_name, presence: true
  has_many :payload_requests

  def self.sort_most_received
    require 'pry'; binding.pry
    group(:event_name).count.sort_by{|k,v|v}.reverse.map{|pair| pair[0]}

    payload_requests.minimum(:responded_in)
  end
end
