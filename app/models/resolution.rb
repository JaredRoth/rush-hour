class Resolution < ActiveRecord::Base
  validates :resolution_width, presence: true
  validates :resolution_height, presence: true
  has_many :payload_requests

  def self.list_resolutions
    width = distinct.pluck(:resolution_width)
    height = distinct.pluck(:resolution_height)
    width.zip(height).map do |pair|
        pair[0].to_s + 'x' + pair[1].to_s
    end
  end
end
