class Referrer < ActiveRecord::Base
  validates :referred_by, presence: true
  has_many :payload_requests
end
