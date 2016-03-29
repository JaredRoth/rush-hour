ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'


Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_urls
    Url.create(:url => "http://jumpstartlab.com/blog")
  end

  def create_referrers
    Referrer.create(:referred_by => "http://jumpstartlab.com")
  end

  def create_request_types
    RequestType.create(:request_type => "GET")
  end

  def create_events
    Event.create(:event_name => "socialLogin")
  end

  def create_user_agents
    UserAgent.create(:user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
  end

  def create_resolutions
    Resolution.create(:resolution_width => "1920", :resolution_height => "1280")
  end

  def create_ips
    Ip.create(:ip => "63.29.38.211")
  end

  def create_payloads
    PayloadRequest.create(:requested_at => "2013-02-16 21:38:28 -0700", :responded_in => 37)
  end
  # create one of these for each table
end
