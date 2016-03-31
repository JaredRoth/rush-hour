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

  def create_referrers
    Referrer.create(:referred_by => "http://jumpstartlab.com")
    Referrer.create(:referred_by => "http://yahoo.com")
    Referrer.create(:referred_by => "http://apple.com")
  end

  def create_request_types
    RequestType.create(:request_type => "GET")
    RequestType.create(:request_type => "GET")
    RequestType.create(:request_type => "POST")
  end

  def create_events
    Event.find_or_create_by(:event_name => "socialLogin")
    Event.find_or_create_by(:event_name => "beginRegistration")
    Event.find_or_create_by(:event_name => "thirdEvent")
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
    PayloadRequest.create(:requested_at     => "2013-02-16 21:38:28 -0700",
                          :responded_in     => 36,
                          :ip_id            => Ip.find_or_create_by(:ip => "63.29.38.213").id,
                          :resolution_id    => Resolution.find_or_create_by(:resolution_width => "720", :resolution_height => "500").id,
                          :user_agent_id    => UserAgentString.find_or_create_by(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.16").id,
                          :event_id         => Event.find_or_create_by(:event_name => "thirdEvent").id,
                          :request_type_id  => RequestType.find_or_create_by(:request_type => "POST").id,
                          :referrer_id      => Referrer.find_or_create_by(:referred_by => "http://apple.com").id,
                          :url_id           => Url.find_or_create_by(:url => "http://yahoo.com/about").id
                          )

    PayloadRequest.create(:requested_at     => "2013-02-16 21:38:28 -0700",
                          :responded_in     => 37,
                          :ip_id            => Ip.find_or_create_by(:ip => "63.29.38.212").id,
                          :resolution_id    => Resolution.find_or_create_by(:resolution_width => "800", :resolution_height => "600").id,
                          :user_agent_id    => UserAgentString.find_or_create_by(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.15").id,
                          :event_id         => Event.find_or_create_by(:event_name => "beginRegistration").id,
                          :request_type_id  => RequestType.find_or_create_by(:request_type => "GET").id,
                          :referrer_id      => Referrer.find_or_create_by(:referred_by => "http://yahoo.com").id,
                          :url_id           => Url.find_or_create_by(:url => "http://yahoo.com/about").id
                          )

    PayloadRequest.create(:requested_at     => "2013-02-16 21:38:28 -0700",
                          :responded_in     => 37,
                          :ip_id            => Ip.find_or_create_by(:ip => "63.29.38.212").id,
                          :resolution_id    => Resolution.find_or_create_by(:resolution_width => "800", :resolution_height => "600").id,
                          :user_agent_id    => UserAgentString.find_or_create_by(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.15").id,
                          :event_id         => Event.find_or_create_by(:event_name => "beginRegistration").id,
                          :request_type_id  => RequestType.find_or_create_by(:request_type => "GET").id,
                          :referrer_id      => Referrer.find_or_create_by(:referred_by => "http://yahoo.com").id,
                          :url_id           => Url.find_or_create_by(:url => "http://jumpstartlab.com/blog").id
                          )

    PayloadRequest.create(:requested_at     => "2013-02-16 21:38:28 -0700",
                          :responded_in     => 38,
                          :ip_id            => Ip.find_or_create_by(:ip => "63.29.38.211").id,
                          :resolution_id    => Resolution.find_or_create_by(:resolution_width => "1920", :resolution_height => "1280").id,
                          :user_agent_id    => UserAgentString.find_or_create_by(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
                          :event_id         => Event.find_or_create_by(:event_name => "socialLogin").id,
                          :request_type_id  => RequestType.find_or_create_by(:request_type => "GET").id,
                          :referrer_id      => Referrer.find_or_create_by(:referred_by => "http://jumpstartlab.com").id,
                          :url_id           => Url.find_or_create_by(:url => "http://jumpstartlab.com/blog").id
                          )

    PayloadRequest.create(:requested_at     => "2013-02-16 21:38:28 -0700",
                          :responded_in     => 35,
                          :ip_id            => Ip.find_or_create_by(:ip => "63.29.38.211").id,
                          :resolution_id    => Resolution.find_or_create_by(:resolution_width => "1920", :resolution_height => "1280").id,
                          :user_agent_id    => UserAgentString.find_or_create_by(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
                          :event_id         => Event.find_or_create_by(:event_name => "socialLogin").id,
                          :request_type_id  => RequestType.find_or_create_by(:request_type => "GET").id,
                          :referrer_id      => Referrer.find_or_create_by(:referred_by => "http://jumpstartlab.com").id,
                          :url_id           => Url.find_or_create_by(:url => "http://jumpstartlab.com/blog").id
                          )

    PayloadRequest.create(:requested_at     => "2013-02-16 21:38:28 -0700",
                          :responded_in     => 39,
                          :ip_id            => Ip.find_or_create_by(:ip => "63.29.38.211").id,
                          :resolution_id    => Resolution.find_or_create_by(:resolution_width => "1920", :resolution_height => "1280").id,
                          :user_agent_id    => UserAgentString.find_or_create_by(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
                          :event_id         => Event.find_or_create_by(:event_name => "socialLogin").id,
                          :request_type_id  => RequestType.find_or_create_by(:request_type => "GET").id,
                          :referrer_id      => Referrer.find_or_create_by(:referred_by => "http://jumpstartlab.com").id,
                          :url_id           => Url.find_or_create_by(:url => "http://jumpstartlab.com/blog").id
                          )
  end
end
