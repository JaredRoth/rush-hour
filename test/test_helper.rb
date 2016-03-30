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
    Url.create(:url => "http://yahoo.com/about")
    Url.create(:url => "http://yahoo.com/about")
  end

  def create_referrers
    Referrer.create(:referred_by => "http://jumpstartlab.com")
    Referrer.create(:referred_by => "http://yahoo.com")
    Referrer.create(:referred_by => "http://apple.com")
  end

  def create_request_types
    RequestType.create(:request_type => "GET")
    RequestType.create(:request_type => "GET")
    RequestType.create(:request_type => "GET")
    RequestType.create(:request_type => "POST")
  end

  def create_events
    Event.create(:event_name => "socialLogin")
    Event.create(:event_name => "beginRegistration")
    Event.create(:event_name => "socialLogin")
    Event.create(:event_name => "socialLogin")
    Event.create(:event_name => "beginRegistration")
    Event.create(:event_name => "thirdEvent")
  end

  def create_user_agent_strings
    UserAgentString.create(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    UserAgentString.create(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.15")
    UserAgentString.create(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.16")
  end

  def create_resolutions
    Resolution.create(:resolution_width => "1920", :resolution_height => "1280")
    Resolution.create(:resolution_width => "800", :resolution_height => "600")
    Resolution.create(:resolution_width => "720", :resolution_height => "500")
  end

  def create_ips
    Ip.create(:ip => "63.29.38.211")
    Ip.create(:ip => "63.29.38.212")
    Ip.create(:ip => "63.29.38.213")
  end

  def create_payloads
    create_urls
    create_referrers
    create_request_types
    create_events
    create_user_agent_strings
    create_resolutions
    create_ips
    PayloadRequest.create(:requested_at => "2013-02-16 21:38:28 -0700",
                          :responded_in => 36,
                          :ip_id => Ip.last.id,
                          :resolution_id => Resolution.last.id,
                          :user_agent_id => UserAgentString.last.id,
                          :event_id => Event.last.id,
                          :request_type_id => RequestType.last.id,
                          :referrer_id => Referrer.last.id,
                          :url_id => Url.last.id
                          )

    PayloadRequest.create(:requested_at => "2013-02-16 21:38:28 -0700",
                          :responded_in => 37,
                          :ip_id => Ip.second.id,
                          :resolution_id => Resolution.second.id,
                          :user_agent_id => UserAgentString.second.id,
                          :event_id => Event.second.id,
                          :request_type_id => RequestType.second.id,
                          :referrer_id => Referrer.second.id,
                          :url_id => Url.last.id
                          )

    PayloadRequest.create(:requested_at => "2013-02-16 21:38:28 -0700",
                          :responded_in => 38,
                          :ip_id => Ip.first.id,
                          :resolution_id => Resolution.first.id,
                          :user_agent_id => UserAgentString.first.id,
                          :event_id => Event.first.id,
                          :request_type_id => RequestType.first.id,
                          :referrer_id => Referrer.first.id,
                          :url_id => Url.find_or_create_by(urls.url = "")
                          )
  end

  def create_nil_payloads
    PayloadRequest.create(:requested_at => nil,
                          :responded_in => nil,
                          :ip_id => nil,
                          :resolution_id => nil,
                          :user_agent_id => nil,
                          :event_id => nil,
                          :request_type_id => nil,
                          :referrer_id => nil,
                          :url_id => nil
                          )
  end
end
