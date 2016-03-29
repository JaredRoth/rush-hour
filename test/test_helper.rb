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
    Referrers.create(:referrer => "http://jumpstartlab.com")
  end

  def create_request_types
    RequestType.create(:request_type => "GET")
  end

  def create_events
    Event.create(:event => "socialLogin")
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

  # create one of these for each table

  # def task_manager
  #   database = Sequel.sqlite('db/task_manager_test.sqlite')
  #   @task_manager ||= TaskManager.new(database)
  # end
  #
  # def create_tasks(num = 2)
  #   num.times do |i|
  #     task_manager.create({
  #       :title => "Task Title #{i + 1}",
  #       :description => "Task Description #{i + 1}"
  #       })
  #   end
  # end
end
