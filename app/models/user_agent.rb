class UserAgent < ActiveRecord::Base
  validates :user_agent, presence: true
  has_many :payload_requests
end
