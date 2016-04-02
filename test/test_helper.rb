ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'tilt/erb'
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

  def create_payloads(num)
    params = [
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 35,
        :payload_sha        => "0a86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.213",
        :resolution_width   => "1920",
        :resolution_height  => "1280",
        :user_agent_os      => "Windows",
        :user_agent_browser => "Chrome",
        :event_name         => "thirdEvent",
        :request_type       => "POST",
        :referred_by        => "http://google.com",
        :url                => "http://jumpstartlab.com/blog",
        :identifier         => "jumpstartlab",
        :rootUrl            => "http://jumpstartlab.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 36,
        :payload_sha        => "1b86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.212",
        :resolution_width   => "720",
        :resolution_height  => "500",
        :user_agent_os      => "Macintosh",
        :user_agent_browser => "Safari",
        :event_name         => "thirdEvent",
        :request_type       => "GET",
        :referred_by        => "http://apple.com",
        :url                => "http://yahoo.com/blog",
        :identifier         => "yahoo",
        :rootUrl            => "http://yahoo.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 37,
        :payload_sha        => "2c86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.211",
        :resolution_width   => "800",
        :resolution_height  => "600",
        :user_agent_os      => "Macintosh",
        :user_agent_browser => "Firefox",
        :event_name         => "beginRegistration",
        :request_type       => "GET",
        :referred_by        => "http://google.com",
        :url                => "http://jumpstartlab.com/about",
        :identifier         => "jumpstartlab",
        :rootUrl            => "http://jumpstartlab.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 38,
        :payload_sha        => "3d86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.212",
        :resolution_width   => "800",
        :resolution_height  => "600",
        :user_agent_os      => "Windows",
        :user_agent_browser => "Safari",
        :event_name         => "beginRegistration",
        :request_type       => "GET",
        :referred_by        => "http://google.com",
        :url                => "http://yahoo.com/about",
        :identifier         => "yahoo",
        :rootUrl            => "http://yahoo.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 39,
        :payload_sha        => "4e86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.211",
        :resolution_width   => "1920",
        :resolution_height  => "1280",
        :user_agent_os      => "Windows",
        :user_agent_browser => "Safari",
        :event_name         => "thirdEvent",
        :request_type       => "GET",
        :referred_by        => "http://jumpstartlab.com",
        :url                => "http://jumpstartlab.com/blog",
        :identifier         => "jumpstartlab",
        :rootUrl            => "http://jumpstartlab.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 35,
        :payload_sha        => "5f86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.211",
        :resolution_width   => "1920",
        :resolution_height  => "1280",
        :user_agent_os      => "Windows",
        :user_agent_browser => "Chrome",
        :event_name         => "socialLogin",
        :request_type       => "GET",
        :referred_by        => "http://yahoo.com",
        :url                => "http://yahoo.com/blog",
        :identifier         => "yahoo",
        :rootUrl            => "http://yahoo.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 38,
        :payload_sha        => "6e86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.211",
        :resolution_width   => "1920",
        :resolution_height  => "1280",
        :user_agent_os      => "Macintosh",
        :user_agent_browser => "Chrome",
        :event_name         => "socialLogin",
        :request_type       => "GET",
        :referred_by        => "http://jumpstartlab.com",
        :url                => "http://jumpstartlab.com/blog",
        :identifier         => "jumpstartlab",
        :rootUrl            => "http://jumpstartlab.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 35,
        :payload_sha        => "7686d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.211",
        :resolution_width   => "1920",
        :resolution_height  => "1280",
        :user_agent_os      => "Macintosh",
        :user_agent_browser => "Safari",
        :event_name         => "socialLogin",
        :request_type       => "GET",
        :referred_by        => "http://google.com",
        :url                => "http://jumpstartlab.com/apply",
        :identifier         => "jumpstartlab",
        :rootUrl            => "http://jumpstartlab.com"
      },
      { :requested_at       => "2013-02-16 21:38:28 -0700",
        :responded_in       => 39,
        :payload_sha        => "8e86d98f1910279f82a56fc686b79c4cd5cb4fa5",
        :ip                 => "63.29.38.211",
        :resolution_width   => "1920",
        :resolution_height  => "1280",
        :user_agent_os      => "Macintosh",
        :user_agent_browser => "Chrome",
        :event_name         => "socialLogin",
        :request_type       => "GET",
        :referred_by        => "http://jumpstartlab.com",
        :url                => "http://jumpstartlab.com/about",
        :identifier         => "jumpstartlab",
        :rootUrl            => "http://jumpstartlab.com"
      },

    ]

    num.times do |i|
      ip                = Ip.find_or_create_by(ip: params[i][:ip])
      resolution        = Resolution.find_or_create_by(resolution_width: params[i][:resolution_width], :resolution_height => params[i][:resolution_height])
      user_agent_string = UserAgentString.find_or_create_by(user_agent_os: params[i][:user_agent_os], :user_agent_browser => params[i][:user_agent_browser])
      event             = Event.find_or_create_by(event_name: params[i][:event_name])
      request_type      = RequestType.find_or_create_by(request_type: params[i][:request_type])
      referrer          = Referrer.find_or_create_by(referred_by: params[i][:referred_by])
      url               = Url.find_or_create_by(url: params[i][:url])
      client            = Client.find_or_create_by(identifier: params[i][:identifier], rootUrl: params[i][:rootUrl])

      PayloadRequest.create(
      :requested_at         => params[i][:requested_at],
      :responded_in         => params[i][:responded_in],
      :payload_sha          => params[i][:payload_sha],
      :ip_id                => ip.id,
      :resolution_id        => resolution.id,
      :user_agent_string_id => user_agent_string.id,
      :event_id             => event.id,
      :request_type_id      => request_type.id,
      :referrer_id          => referrer.id,
      :url_id               => url.id,
      :client_id            => client.id
      )
    end
  end
end


# .match(/\w+\z/)[0],
