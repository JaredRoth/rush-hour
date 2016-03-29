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
